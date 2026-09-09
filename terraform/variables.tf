# eks-platform-infra/terraform/variables.tf

variable "aws_region" {
  description = "AWS region for provisioning resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-platform-dev"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "single_nat_gateway" {
  description = "Enable single NAT Gateway for development cost savings"
  type        = bool
  default     = true
}

variable "system_node_desired_size" {
  description = "Desired number of bootstrap/system worker nodes"
  type        = number
  default     = 2
}

variable "system_node_min_size" {
  description = "Minimum number of bootstrap/system worker nodes"
  type        = number
  default     = 2
}

variable "system_node_max_size" {
  description = "Maximum number of bootstrap/system worker nodes"
  type        = number
  default     = 4
}

variable "system_node_instance_types" {
  description = "Instance types for system managed node group"
  type        = list(string)
  default     = ["t3.medium", "t3a.medium"]
}

variable "frontend_repo_name" {
  description = "Name of the frontend ECR repository"
  type        = string
  default     = "frontend-app"
}

variable "backend_repo_name" {
  description = "Name of the backend ECR repository"
  type        = string
  default     = "backend-app"
}

variable "sender_email" {
  description = "Verified email address for Amazon SES"
  type        = string
  default     = "devops-alerts@example.com"
}

variable "domain_name" {
  description = "Custom domain for SES verification (optional)"
  type        = string
  default     = ""
}

variable "create_github_oidc_provider" {
  description = "Create GitHub OIDC provider if not already existing in AWS account"
  type        = bool
  default     = false
}

variable "github_repo_subjects" {
  description = "GitHub repository subject patterns allowed to push to ECR (e.g., repo:org/repo:*)"
  type        = list(string)
  default     = ["repo:*:*"]
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana UI"
  type        = string
  default     = "prom-operator"
  sensitive   = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default = {
    Project     = "Cloud-Native EKS Platform with GitOps, Autoscaling & Observability"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
