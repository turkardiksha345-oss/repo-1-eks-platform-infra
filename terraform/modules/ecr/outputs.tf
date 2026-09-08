# eks-platform-infra/terraform/modules/ecr/outputs.tf

output "frontend_repository_url" {
  description = "The URL of the frontend ECR repository"
  value       = aws_ecr_repository.repos["frontend"].repository_url
}

output "frontend_repository_arn" {
  description = "The ARN of the frontend ECR repository"
  value       = aws_ecr_repository.repos["frontend"].arn
}

output "backend_repository_url" {
  description = "The URL of the backend ECR repository"
  value       = aws_ecr_repository.repos["backend"].repository_url
}

output "backend_repository_arn" {
  description = "The ARN of the backend ECR repository"
  value       = aws_ecr_repository.repos["backend"].arn
}

output "all_repository_arns" {
  description = "List of all created ECR repository ARNs"
  value       = [for repo in aws_ecr_repository.repos : repo.arn]
}
