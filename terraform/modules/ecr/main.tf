# eks-platform-infra/terraform/modules/ecr/main.tf

locals {
  repositories = {
    frontend = var.frontend_repo_name
    backend  = var.backend_repo_name
  }
}

resource "aws_ecr_repository" "repos" {
  for_each             = local.repositories
  name                 = each.value
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = merge(
    var.tags,
    {
      Component = each.key
    }
  )
}

# -----------------------------------------------------------------------------
# Lifecycle Policy (Retain last 30 releases, expire untagged after 7 days)
# -----------------------------------------------------------------------------
resource "aws_ecr_lifecycle_policy" "policy" {
  for_each   = aws_ecr_repository.repos
  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images older than 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep last 30 tagged images"
        selection = {
          tagStatus     = "tagged"
          tagPrefixList = ["v", "sha-", "prod-", "dev-"]
          countType     = "imageCount"
          countNumber   = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
