variable "cluster_name" {}
variable "role_arn" {}
variable "security_group_id" {type = set(string)}
variable "subnet_id" {  type        = list(string)}
# variable "eks_cluster_policy_arns" {  type        = list(string)}
variable "eks_cluster_policy_attachment" {type        = list(string)}
variable "instance_type" {}
variable "eks_node_arn" {}
variable "node_desired_size" {}
variable "node_max_size" {}
variable "node_min_size" {}
# variable "node_policy_arns" {  type        = list(string)}
variable "eks_node_policy_attachment" {type        = list(string)}
variable "eks_node_instance_profile" {}
variable "private_access" {
  type        = bool
  default     = true
}