# eks-platform-infra/terraform/environments/dev/variables.tf

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "cluster_name" {
  type    = string
  default = "eks-platform-dev"
}

variable "cluster_version" {
  type    = string
  default = "1.30"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "system_node_desired_size" {
  type    = number
  default = 2
}

variable "system_node_min_size" {
  type    = number
  default = 2
}

variable "system_node_max_size" {
  type    = number
  default = 4
}

variable "system_node_instance_types" {
  type    = list(string)
  default = ["t3.medium", "t3a.medium"]
}

variable "frontend_repo_name" {
  type    = string
  default = "frontend-app"
}

variable "backend_repo_name" {
  type    = string
  default = "backend-app"
}

variable "sender_email" {
  type    = string
  default = "devops-alerts@example.com"
}

variable "domain_name" {
  type    = string
  default = ""
}

variable "create_github_oidc_provider" {
  type    = bool
  default = true
}

variable "github_repo_subjects" {
  type    = list(string)
  default = ["repo:*:*"]
}

variable "grafana_admin_password" {
  type      = string
  default   = "prom-operator"
  sensitive = true
}

variable "tags" {
  type = map(string)
  default = {
    Project     = "Cloud-Native EKS Platform with GitOps, Autoscaling & Observability"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
