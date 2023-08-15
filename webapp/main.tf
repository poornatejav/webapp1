module "vpc" {
  source = "../modules/vpc"
  region = var.region
  project = var.project
  vpc_cidr = var.vpc_cidr
  public_cidr = var.public_cidr
  private_cidr = var.private_cidr

}

module "nat_gateway" {
  source = "../modules/nat-gateway"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  internet_gateway = module.vpc.internet_gateway
}

module "security_group" {
  source = "../modules/security-group"
  vpc_id = module.vpc.vpc_id
  ingressrules = var.ingressrules
  egressrules = var.egressrules
}

module "s3" {
    source = "../modules/s3"
    bucket_name = var.bucket_name
    object_key = var.object_key
    source_path = var.source_path
  
}

module "key_pair" {
  source = "../modules/key-pair"
  key_name = var.key_name
  public_key = var.public_key

}

module "ec2_public" {
  source = "../modules/ec2"
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnet_id
  security_group_id = module.security_group.security_group_id
  instance_profile = ""
  key_name = module.key_pair.key_pair_name
  user_data = file("../templates/public.tpl")
}

module "ec2_private" {
  source = "../modules/ec2"
  instance_type = var.instance_type
  subnet_id = module.vpc.private_subnet_id
  security_group_id = module.security_group.security_group_id
  instance_profile = module.s3.iam_instance_profile
  key_name = module.key_pair.key_pair_name
  user_data = file("../templates/public.tpl")
}