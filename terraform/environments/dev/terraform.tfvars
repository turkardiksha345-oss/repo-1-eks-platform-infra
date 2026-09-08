# eks-platform-infra/terraform/environments/dev/terraform.tfvars

aws_region   = "us-east-1"
environment  = "dev"
cluster_name = "eks-platform-dev"

vpc_cidr           = "10.0.0.0/16"
single_nat_gateway = true

system_node_desired_size   = 2
system_node_min_size       = 2
system_node_max_size       = 4
system_node_instance_types = ["t3.medium", "t3a.medium"]

frontend_repo_name = "frontend-app"
backend_repo_name  = "backend-app"

sender_email = "devops-alerts@example.com"
domain_name  = ""

create_github_oidc_provider = true
github_repo_subjects        = [
  "repo:*:*"
]

grafana_admin_password = "prom-operator"

tags = {
  Project     = "Cloud-Native EKS Platform with GitOps, Autoscaling & Observability"
  Environment = "dev"
  ManagedBy   = "Terraform"
}
