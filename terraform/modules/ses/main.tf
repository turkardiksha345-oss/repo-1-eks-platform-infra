# eks-platform-infra/terraform/modules/ses/main.tf

# -----------------------------------------------------------------------------
# SES Configuration Set
# -----------------------------------------------------------------------------
resource "aws_ses_configuration_set" "main" {
  name = var.ses_configuration_set_name

  reputation_metrics_enabled = true
  sending_enabled            = true
}

# -----------------------------------------------------------------------------
# SES Email Identity (Sender)
# -----------------------------------------------------------------------------
resource "aws_ses_email_identity" "sender" {
  count = var.sender_email != "" ? 1 : 0
  email = var.sender_email
}

# -----------------------------------------------------------------------------
# SES Domain Identity (Optional for custom domain)
# -----------------------------------------------------------------------------
resource "aws_ses_domain_identity" "domain" {
  count  = var.domain_name != "" ? 1 : 0
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "dkim" {
  count  = var.domain_name != "" ? 1 : 0
  domain = aws_ses_domain_identity.domain[0].domain
}

# -----------------------------------------------------------------------------
# IAM Policy for Backend Email Sending
# -----------------------------------------------------------------------------
resource "aws_iam_policy" "ses_sender" {
  name        = "${var.cluster_name}-ses-sender-policy"
  description = "IAM Policy allowing Backend application to send emails via SES"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail",
          "ses:SendTemplatedEmail",
          "ses:GetSendQuota",
          "ses:GetSendStatistics"
        ]
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}
