# eks-platform-infra/terraform/modules/ingress-nginx/outputs.tf

output "namespace" {
  description = "Namespace where Ingress NGINX is deployed"
  value       = var.namespace
}

output "release_name" {
  description = "Release name of Ingress NGINX"
  value       = helm_release.ingress_nginx.name
}
