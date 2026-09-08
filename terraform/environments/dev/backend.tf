# eks-platform-infra/terraform/environments/dev/backend.tf

terraform {
  backend "s3" {
    bucket         = "eks-platform-terraform-state-bucket"
    key            = "environments/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eks-platform-terraform-lock-table"
    encrypt        = true
  }
}
