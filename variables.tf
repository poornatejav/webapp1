variable "region" {
}

variable "project" {
}
variable "cluster_name" {
}

variable "cluster_version" {
}

variable "cluster_endpoint_public_access" {
  type        = bool
}

variable "cluster_addons" {
  type        = map(object({
    most_recent = bool
  }))
}

variable "vpc_cidr" {
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "public_subnet_ids" {
  type        = list(string)
}

variable "ingressrules" {
}

variable "egressrules" {
}

variable "eks_cluster_policy_attachment" {}
variable "eks_node_policy_attachment" {}

variable "self_managed_node_group_defaults" {
  type        = object({
    instance_type                          = string
    update_launch_template_default_version = bool
    iam_role_additional_policies           = map(string)
  })
}

variable "self_managed_node_groups" {
  description = "Configuration for self-managed node groups"
  type        = map(object({
    name                   = string
    max_size               = number
    desired_size           = number
    use_mixed_instances_policy = bool
    instance_type         = string
  }))
}

# variable "self_managed_node_groups" {
#   type        = map(object({
#     name                     = string
#     max_size                 = number
#     desired_size             = number
#     use_mixed_instances_policy = bool
#     mixed_instances_policy   = object({
#       instances_distribution = object({
#         on_demand_base_capacity                  = number
#         on_demand_percentage_above_base_capacity = number
#         spot_allocation_strategy                 = string
#       })
#       override = list(object({
#         instance_type     = string
#         weighted_capacity = string
#       }))
#     })
#   }))
# }

# variable "eks_managed_node_group_defaults" {
#   type        = object({
#     instance_types = list(string)
#   })
# }

# variable "eks_managed_node_groups" {
#   type        = map(object({
#     min_size      = number
#     max_size      = number
#     desired_size  = number
#     instance_types = list(string)
#     capacity_type  = string
#   }))
# }

# variable "fargate_profiles" {
#   type        = map(object({
#     name      = string
#     selectors = list(object({
#       namespace = string
#     }))
#   }))
# }

variable "manage_aws_auth_configmap" {
  type        = bool
}

# variable "aws_auth_roles" {
#   type        = list(object({
#     rolearn  = string
#     username = string
#     groups   = list(string)
#   }))
# }

variable "aws_auth_users" {
  type        = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}

variable "aws_auth_accounts" {
  type        = list(string)
}

variable "tags" {
   type        = map(string)
}
