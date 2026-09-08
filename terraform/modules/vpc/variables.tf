# eks-platform-infra/terraform/modules/vpc/variables.tf

variable "cluster_name" {
  description = "Name of the EKS cluster used for resource naming and tagging"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "max_azs" {
  description = "Maximum number of Availability Zones to utilize"
  type        = number
  default     = 3
}

variable "single_nat_gateway" {
  description = "Whether to use a single NAT Gateway (for cost saving in dev) or one per AZ"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
