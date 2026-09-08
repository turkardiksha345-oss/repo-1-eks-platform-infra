# eks-platform-infra/terraform/modules/eks/variables.tf

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

variable "vpc_id" {
  description = "VPC ID where EKS is deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for worker nodes"
  type        = list(string)
}

variable "system_node_instance_types" {
  description = "Instance types for system managed node group"
  type        = list(string)
  default     = ["t3.medium", "t3a.medium"]
}

variable "system_node_desired_size" {
  description = "Desired number of bootstrap/system worker nodes"
  type        = number
  default     = 2
}

variable "system_node_min_size" {
  description = "Minimum number of bootstrap/system worker nodes"
  type        = number
  default     = 2
}

variable "system_node_max_size" {
  description = "Maximum number of bootstrap/system worker nodes"
  type        = number
  default     = 4
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
