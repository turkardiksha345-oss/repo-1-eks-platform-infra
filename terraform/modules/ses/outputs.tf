# eks-platform-infra/terraform/modules/ses/outputs.tf

output "configuration_set_name" {
  description = "The name of the SES configuration set"
  value       = aws_ses_configuration_set.main.name
}

output "sender_email_identity_arn" {
  description = "The ARN of the verified sender email identity"
  value       = length(aws_ses_email_identity.sender) > 0 ? aws_ses_email_identity.sender[0].arn : null
}

output "sender_email" {
  description = "The verified sender email address"
  value       = var.sender_email
}

output "ses_sender_policy_arn" {
  description = "ARN of the IAM policy for sending emails"
  value       = aws_iam_policy.ses_sender.arn
}
