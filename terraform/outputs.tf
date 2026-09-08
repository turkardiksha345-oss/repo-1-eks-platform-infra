# eks-platform-infra/terraform/outputs.tf

# -----------------------------------------------------------------------------
# AWS Region & Environment
# -----------------------------------------------------------------------------
output "aws_region" {
  description = "AWS Region of deployment"
  value       = var.aws_region
}

output "environment" {
  description = "Deployment Environment"
  value       = var.environment
}

# -----------------------------------------------------------------------------
# VPC Outputs
# -----------------------------------------------------------------------------
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnets" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnet_ids
}

# -----------------------------------------------------------------------------
# EKS Cluster Outputs
# -----------------------------------------------------------------------------
output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster API Endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security Group ID of the EKS Cluster"
  value       = module.eks.cluster_security_group_id
}

output "oidc_provider_arn" {
  description = "OIDC Provider ARN for IRSA"
  value       = module.eks.oidc_provider_arn
}

output "oidc_provider_url" {
  description = "OIDC Provider URL"
  value       = module.eks.oidc_provider_url
}

# -----------------------------------------------------------------------------
# ECR Outputs
# -----------------------------------------------------------------------------
output "frontend_ecr_repository_url" {
  description = "Frontend ECR Repository URL"
  value       = module.ecr.frontend_repository_url
}

output "backend_ecr_repository_url" {
  description = "Backend ECR Repository URL"
  value       = module.ecr.backend_repository_url
}

# -----------------------------------------------------------------------------
# IAM & IRSA Outputs
# -----------------------------------------------------------------------------
output "github_actions_ecr_role_arn" {
  description = "IAM Role ARN for GitHub Actions ECR Push"
  value       = module.iam.github_actions_ecr_role_arn
}

output "backend_ses_role_arn" {
  description = "IAM Role ARN for Backend Pod to send emails via SES (IRSA)"
  value       = module.iam.backend_ses_role_arn
}

# -----------------------------------------------------------------------------
# SES Outputs
# -----------------------------------------------------------------------------
output "ses_sender_email" {
  description = "Verified SES Sender Email"
  value       = module.ses.sender_email
}

output "ses_configuration_set_name" {
  description = "SES Configuration Set Name"
  value       = module.ses.configuration_set_name
}

# -----------------------------------------------------------------------------
# Karpenter Outputs
# -----------------------------------------------------------------------------
output "karpenter_controller_role_arn" {
  description = "Karpenter Controller IRSA Role ARN"
  value       = module.iam.karpenter_controller_role_arn
}

output "karpenter_node_instance_profile_name" {
  description = "Karpenter Node Instance Profile Name"
  value       = module.iam.karpenter_node_instance_profile_name
}

output "karpenter_interruption_queue_name" {
  description = "Karpenter Interruption SQS Queue Name"
  value       = module.karpenter.interruption_queue_name
}

# -----------------------------------------------------------------------------
# Platform Namespaces
# -----------------------------------------------------------------------------
output "argocd_namespace" {
  description = "ArgoCD Namespace"
  value       = module.argocd.namespace
}

output "ingress_nginx_namespace" {
  description = "Ingress NGINX Namespace"
  value       = module.ingress_nginx.namespace
}

output "monitoring_namespace" {
  description = "Observability Namespace (Prometheus/Grafana/Loki)"
  value       = module.observability.namespace
}
