# eks-platform-infra/terraform/modules/ecr/variables.tf

variable "frontend_repo_name" {
  description = "Name of the ECR repository for the frontend application"
  type        = string
  default     = "frontend-app"
}

variable "backend_repo_name" {
  description = "Name of the ECR repository for the backend application"
  type        = string
  default     = "backend-app"
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "MUTABLE" # Set to MUTABLE to support dev/staging workflows, while CI pushes immutable git sha tags
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
