variable "region" {}
variable "project" {}
variable "instance_type" {}
variable "vpc_cidr" {}
variable "public_cidr" {}
variable "private_cidr" {}
variable "ingressrules" {}
variable "egressrules" {}
variable "key_name" {}
variable "public_key" {}
variable "cluster_name" {}
# variable "role_arn" {}
# variable "security_group_id" {  type        = list(string)}
# variable "subnet_id" {  type        = list(string)}
variable "eks_cluster_policy_attachment" {}
variable "eks_node_policy_attachment" {}
variable "private_access" {}
# variable "eks_node_arn" {}
variable "node_desired_size" {}
variable "node_max_size" {}
variable "node_min_size" {}
