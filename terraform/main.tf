# eks-platform-infra/terraform/main.tf

# -----------------------------------------------------------------------------
# 1. VPC Module
# -----------------------------------------------------------------------------
module "vpc" {
  source = "./modules/vpc"

  cluster_name       = var.cluster_name
  vpc_cidr           = var.vpc_cidr
  max_azs            = 3
  single_nat_gateway = var.single_nat_gateway
  tags               = var.tags
}

# -----------------------------------------------------------------------------
# 2. EKS Cluster Module
# -----------------------------------------------------------------------------
module "eks" {
  source = "./modules/eks"

  cluster_name               = var.cluster_name
  cluster_version            = var.cluster_version
  vpc_id                     = module.vpc.vpc_id
  public_subnet_ids          = module.vpc.public_subnet_ids
  private_subnet_ids         = module.vpc.private_subnet_ids
  system_node_instance_types = var.system_node_instance_types
  system_node_desired_size   = var.system_node_desired_size
  system_node_min_size       = var.system_node_min_size
  system_node_max_size       = var.system_node_max_size
  tags                       = var.tags

  depends_on = [module.vpc]
}

# -----------------------------------------------------------------------------
# 3. ECR Repositories Module
# -----------------------------------------------------------------------------
module "ecr" {
  source = "./modules/ecr"

  frontend_repo_name   = var.frontend_repo_name
  backend_repo_name    = var.backend_repo_name
  image_tag_mutability = "MUTABLE"
  tags                 = var.tags
}

# -----------------------------------------------------------------------------
# 4. Amazon SES Module
# -----------------------------------------------------------------------------
module "ses" {
  source = "./modules/ses"

  cluster_name = var.cluster_name
  sender_email = var.sender_email
  domain_name  = var.domain_name
  tags         = var.tags
}

# -----------------------------------------------------------------------------
# 5. IAM & OIDC / IRSA Module
# -----------------------------------------------------------------------------
module "iam" {
  source = "./modules/iam"

  cluster_name                 = var.cluster_name
  aws_region                   = var.aws_region
  oidc_provider_arn            = module.eks.oidc_provider_arn
  oidc_provider_url            = module.eks.oidc_provider_url
  backend_namespace            = "backend"
  backend_service_account_name = "backend-ses-sa"
  create_github_oidc_provider  = var.create_github_oidc_provider
  github_repo_subjects         = var.github_repo_subjects
  ecr_repository_arns          = module.ecr.all_repository_arns
  tags                         = var.tags

  depends_on = [module.eks, module.ecr]
}

# -----------------------------------------------------------------------------
# 6. Karpenter Module
# -----------------------------------------------------------------------------
module "karpenter" {
  source = "./modules/karpenter"

  cluster_name                         = module.eks.cluster_name
  cluster_endpoint                     = module.eks.cluster_endpoint
  karpenter_version                    = "1.0.1"
  karpenter_controller_role_arn        = module.iam.karpenter_controller_role_arn
  karpenter_node_instance_profile_name = module.iam.karpenter_node_instance_profile_name
  tags                                 = var.tags

  depends_on = [module.eks, module.iam]
}

# -----------------------------------------------------------------------------
# 7. ArgoCD Module
# -----------------------------------------------------------------------------
module "argocd" {
  source = "./modules/argocd"

  argocd_namespace     = "argocd"
  argocd_chart_version = "7.4.5"
  tags                 = var.tags

  depends_on = [module.eks]
}

# -----------------------------------------------------------------------------
# 8. Ingress NGINX Controller Module
# -----------------------------------------------------------------------------
module "ingress_nginx" {
  source = "./modules/ingress-nginx"

  namespace     = "ingress-nginx"
  chart_version = "4.11.2"
  replica_count = 2
  tags          = var.tags

  depends_on = [module.eks]
}

# -----------------------------------------------------------------------------
# 9. Observability Stack Module (Prometheus + Loki + Grafana)
# -----------------------------------------------------------------------------
module "observability" {
  source = "./modules/observability"

  monitoring_namespace          = "monitoring"
  grafana_admin_password        = var.grafana_admin_password
  kube_prometheus_stack_version = "62.7.0"
  loki_version                  = "6.12.0"
  promtail_version              = "6.16.0"
  tags                          = var.tags

  depends_on = [module.eks]
}
