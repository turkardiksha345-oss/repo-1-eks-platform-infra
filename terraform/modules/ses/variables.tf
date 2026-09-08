# eks-platform-infra/terraform/modules/ses/variables.tf

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "ses_configuration_set_name" {
  description = "Name of the SES configuration set"
  type        = string
  default     = "eks-platform-ses-config"
}

variable "sender_email" {
  description = "Email address to verify in Amazon SES for sending notifications"
  type        = string
  default     = "devops-alerts@example.com"
}

variable "domain_name" {
  description = "Domain name to verify in Amazon SES (leave empty if verifying single email address)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
