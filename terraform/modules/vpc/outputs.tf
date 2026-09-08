# eks-platform-infra/terraform/modules/vpc/outputs.tf

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs for EKS worker nodes and Karpenter"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_ips" {
  description = "Elastic IP addresses allocated for the NAT Gateway(s)"
  value       = aws_eip.nat[*].public_ip
}
