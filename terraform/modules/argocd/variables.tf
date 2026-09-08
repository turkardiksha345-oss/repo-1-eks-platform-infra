# eks-platform-infra/terraform/modules/argocd/variables.tf

variable "argocd_namespace" {
  description = "Namespace for ArgoCD installation"
  type        = string
  default     = "argocd"
}

variable "argocd_chart_version" {
  description = "Helm chart version for ArgoCD"
  type        = string
  default     = "7.4.5"
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
