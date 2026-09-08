# eks-platform-infra/terraform/environments/dev/main.tf

module "platform" {
  source = "../../"

  aws_region                 = var.aws_region
  environment                = var.environment
  cluster_name               = var.cluster_name
  cluster_version            = var.cluster_version
  vpc_cidr                   = var.vpc_cidr
  single_nat_gateway         = var.single_nat_gateway
  system_node_instance_types = var.system_node_instance_types
  system_node_desired_size   = var.system_node_desired_size
  system_node_min_size       = var.system_node_min_size
  system_node_max_size       = var.system_node_max_size

  frontend_repo_name = var.frontend_repo_name
  backend_repo_name  = var.backend_repo_name

  sender_email = var.sender_email
  domain_name  = var.domain_name

  create_github_oidc_provider = var.create_github_oidc_provider
  github_repo_subjects        = var.github_repo_subjects

  grafana_admin_password = var.grafana_admin_password
  tags                   = var.tags
}
