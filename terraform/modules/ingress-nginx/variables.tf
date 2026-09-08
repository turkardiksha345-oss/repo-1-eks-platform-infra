# eks-platform-infra/terraform/modules/ingress-nginx/variables.tf

variable "namespace" {
  description = "Namespace for ingress-nginx"
  type        = string
  default     = "ingress-nginx"
}

variable "chart_version" {
  description = "Chart version for ingress-nginx"
  type        = string
  default     = "4.11.2"
}

variable "replica_count" {
  description = "Replica count for Ingress Controller"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
