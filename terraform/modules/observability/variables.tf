# eks-platform-infra/terraform/modules/observability/variables.tf

variable "monitoring_namespace" {
  description = "Kubernetes namespace for Prometheus, Grafana, and Loki"
  type        = string
  default     = "monitoring"
}

variable "grafana_admin_password" {
  description = "Admin password for Grafana UI"
  type        = string
  default     = "prom-operator"
  sensitive   = true
}

variable "kube_prometheus_stack_version" {
  description = "Helm chart version for kube-prometheus-stack"
  type        = string
  default     = "62.7.0"
}

variable "loki_version" {
  description = "Helm chart version for Loki"
  type        = string
  default     = "6.12.0"
}

variable "promtail_version" {
  description = "Helm chart version for Promtail"
  type        = string
  default     = "6.16.0"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
