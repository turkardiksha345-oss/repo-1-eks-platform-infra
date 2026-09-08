# eks-platform-infra/terraform/backend.tf

terraform {
  backend "s3" {
    bucket         = "eks-platform-terraform-state-bucket"
    key            = "infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eks-platform-terraform-lock-table"
    encrypt        = true
  }
}
