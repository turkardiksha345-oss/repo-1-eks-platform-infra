# eks-platform-infra/terraform/modules/iam/variables.tf

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC Provider"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL of the EKS OIDC Provider (without https://)"
  type        = string
}

variable "backend_namespace" {
  description = "Kubernetes namespace for the backend application"
  type        = string
  default     = "backend"
}

variable "backend_service_account_name" {
  description = "Kubernetes ServiceAccount name for the backend application"
  type        = string
  default     = "backend-ses-sa"
}

variable "create_github_oidc_provider" {
  description = "Whether to create the GitHub OIDC provider (false if already exists in AWS account)"
  type        = bool
  default     = true
}

variable "github_repo_subjects" {
  description = "GitHub repository subject patterns allowed to assume the ECR push role (e.g. repo:org/repo:*)"
  type        = list(string)
  default     = ["repo:*:*"]
}

variable "ecr_repository_arns" {
  description = "List of ECR repository ARNs that GitHub Actions is permitted to push to"
  type        = list(string)
  default     = ["*"]
}

variable "karpenter_sqs_queue_arn" {
  description = "ARN of the Karpenter SQS Interruption Queue"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
