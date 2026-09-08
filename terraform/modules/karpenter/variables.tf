# eks-platform-infra/terraform/modules/karpenter/variables.tf

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS API Cluster endpoint URL"
  type        = string
}

variable "karpenter_version" {
  description = "Karpenter Helm chart version"
  type        = string
  default     = "1.0.1"
}

variable "karpenter_controller_role_arn" {
  description = "IAM Role ARN for Karpenter Controller IRSA"
  type        = string
}

variable "karpenter_node_instance_profile_name" {
  description = "IAM Instance Profile name for Karpenter worker nodes"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
