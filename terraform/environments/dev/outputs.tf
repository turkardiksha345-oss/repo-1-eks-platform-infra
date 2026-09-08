# eks-platform-infra/terraform/environments/dev/outputs.tf

output "cluster_name" {
  value = module.platform.cluster_name
}

output "cluster_endpoint" {
  value = module.platform.cluster_endpoint
}

output "oidc_provider_arn" {
  value = module.platform.oidc_provider_arn
}

output "frontend_ecr_repository_url" {
  value = module.platform.frontend_ecr_repository_url
}

output "backend_ecr_repository_url" {
  value = module.platform.backend_ecr_repository_url
}

output "github_actions_ecr_role_arn" {
  value = module.platform.github_actions_ecr_role_arn
}

output "backend_ses_role_arn" {
  value = module.platform.backend_ses_role_arn
}

output "ses_sender_email" {
  value = module.platform.ses_sender_email
}

output "karpenter_controller_role_arn" {
  value = module.platform.karpenter_controller_role_arn
}

output "karpenter_node_instance_profile_name" {
  value = module.platform.karpenter_node_instance_profile_name
}
