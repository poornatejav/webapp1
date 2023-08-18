module "vpc" {
  source = "../modules/vpc"  
  region = var.region
  vpc_cidr      = var.vpc_cidr
  project       = var.project
  public_cidr   = var.public_cidr
  private_cidr  = var.private_cidr
}

module "security_group" {
  source = "../modules/security-group"
  vpc_id = module.vpc.vpc_id
  ingressrules = var.ingressrules
  egressrules = var.egressrules
}

module "iam" {
  source = "../modules/iam"
  eks_cluster_policy_attachment = var.eks_cluster_policy_attachment
  eks_node_policy_attachment    = var.eks_node_policy_attachment  
}

module "eks" {
  source = "../modules/eks"  
  cluster_name            = var.cluster_name
  role_arn                = module.iam.eks_cluster_role_arn
  security_group_id     = [module.security_group.security_group_id]
  subnet_id            = module.vpc.private_subnet_id
  private_access = var.private_access
  eks_cluster_policy_attachment = module.iam.eks_cluster_policy_attachment
  instance_type = var.instance_type
  eks_node_arn            = module.iam.eks_node_role_arn
  node_desired_size       = var.node_desired_size
  node_max_size           = var.node_max_size
  node_min_size           = var.node_min_size
  eks_node_policy_attachment    = module.iam.eks_node_policy_attachment
  eks_node_instance_profile = module.iam.eks_node_instance_profile
}

module "key_pair" {
  source = "../modules/key-pair"
  key_name = var.key_name
  public_key = var.public_key

}
module "ec2" {
  source = "../modules/ec2"
  instance_type = var.instance_type
  subnet_id           = module.vpc.public_subnet_id[0]
  security_group_id = module.security_group.security_group_id
  instance_profile = module.iam.eks_cluster_instance_profile

  user_data = "../templates/kube_ec2.tpl"
  key_name = module.key_pair.key_pair_name
}

