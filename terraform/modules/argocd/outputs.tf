# eks-platform-infra/terraform/modules/argocd/outputs.tf

output "namespace" {
  description = "Namespace where ArgoCD is deployed"
  value       = var.argocd_namespace
}

output "release_name" {
  description = "Helm release name for ArgoCD"
  value       = helm_release.argocd.name
}
