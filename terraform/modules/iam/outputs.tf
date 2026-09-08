# eks-platform-infra/terraform/modules/iam/outputs.tf

output "github_actions_ecr_role_arn" {
  description = "IAM Role ARN for GitHub Actions ECR authentication"
  value       = aws_iam_role.github_actions_ecr.arn
}

output "backend_ses_role_arn" {
  description = "IAM Role ARN for Backend ServiceAccount IRSA (SES access)"
  value       = aws_iam_role.backend_ses.arn
}

output "karpenter_controller_role_arn" {
  description = "IAM Role ARN for Karpenter Controller IRSA"
  value       = aws_iam_role.karpenter_controller.arn
}

output "karpenter_node_role_arn" {
  description = "IAM Role ARN for Karpenter provisioned EC2 nodes"
  value       = aws_iam_role.karpenter_node.arn
}

output "karpenter_node_instance_profile_name" {
  description = "Instance Profile Name for Karpenter provisioned EC2 nodes"
  value       = aws_iam_instance_profile.karpenter_node.name
}
