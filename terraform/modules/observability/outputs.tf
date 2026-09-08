# eks-platform-infra/terraform/modules/observability/outputs.tf

output "namespace" {
  description = "Namespace where observability stack is deployed"
  value       = var.monitoring_namespace
}

output "prometheus_release_name" {
  description = "Helm release name for kube-prometheus-stack"
  value       = helm_release.kube_prometheus_stack.name
}

output "loki_release_name" {
  description = "Helm release name for Loki"
  value       = helm_release.loki.name
}

output "promtail_release_name" {
  description = "Helm release name for Promtail"
  value       = helm_release.promtail.name
}
