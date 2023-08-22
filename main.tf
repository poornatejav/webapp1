module "vpc" {
  source       = "../modules/vpc"
  region       = var.region
  vpc_cidr     = var.vpc_cidr
  project      = var.project
  public_cidr  = var.public_subnet_ids
  private_cidr = var.private_subnet_ids
}

module "security_group" {
  source       = "../modules/security-group"
  vpc_id       = module.vpc.vpc_id
  ingressrules = var.ingressrules
  egressrules  = var.egressrules
}

module "iam" {
  source                        = "../modules/iam"
  eks_cluster_policy_attachment = var.eks_cluster_policy_attachment
  eks_node_policy_attachment    = var.eks_node_policy_attachment
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  cluster_addons = var.cluster_addons

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.public_subnet_ids

  self_managed_node_group_defaults = var.self_managed_node_group_defaults

  self_managed_node_groups = var.self_managed_node_groups

#   eks_managed_node_group_defaults = var.eks_managed_node_group_defaults

#   eks_managed_node_groups = var.eks_managed_node_groups

#   fargate_profiles = var.fargate_profiles

  manage_aws_auth_configmap = var.manage_aws_auth_configmap

  aws_auth_roles = [
    {
      userarn  = module.iam.eks_cluster_role_arn
      username = "terraform"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users     = var.aws_auth_users
  aws_auth_accounts  = var.aws_auth_accounts

  tags = var.tags
}
