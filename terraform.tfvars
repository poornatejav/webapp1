region = "us-east-1"
vpc_cidr = "10.0.0.0/16"
project = "web_app"
private_subnet_ids              = ["10.0.0.0/24", "10.0.1.0/24"]
public_subnet_ids               = ["10.0.2.0/24", "10.0.3.0/24"]
ingressrules = [22,80]
egressrules = [0]
cluster_name    = "my-cluster"
cluster_version = "1.27"

cluster_endpoint_public_access = false

cluster_addons = {
  coredns = {
    most_recent = true
  }
  kube-proxy = {
    most_recent = true
  }
  vpc-cni = {
    most_recent = true
  }
}


self_managed_node_group_defaults = {
  instance_type                          = "t2.micro"
  update_launch_template_default_version = true
  iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}


self_managed_node_groups = {
  web_app = {
    name         = "t2-micro"
    max_size     = 3
    desired_size = 1
    use_mixed_instances_policy = false   
    instance_type = "t2.micro"  
  }
}


# self_managed_node_groups = {
#   one = {
#     name         = "mixed-1"
#     max_size     = 3
#     desired_size = 1

#     use_mixed_instances_policy = true
#     mixed_instances_policy = {
#       instances_distribution = {
#         on_demand_base_capacity                  = 0
#         on_demand_percentage_above_base_capacity = 10
#         spot_allocation_strategy                 = "capacity-optimized"
#       }

#       override = [
#         {
#           instance_type     = "t2.micro"
#           weighted_capacity = "1"
#         },
#         {
#           instance_type     = "t2.micro"
#           weighted_capacity = "2"
#         },
#       ]
#     }
#   }
# }

# eks_managed_node_group_defaults = {
#   instance_types = ["t2.micro"]
# }

# eks_managed_node_groups = {
#   web_app = {
#     min_size     = 1
#     max_size     = 3
#     desired_size = 1

#     instance_types = ["t2.micro"]
#     # capacity_type  = "SPOT"
#     capacity_type  = "ON_DEMAND"

#   }
# }

# fargate_profiles = {
#   default = {
#     name = "default"
#     selectors = [
#       {
#         namespace = "default"
#       }
#     ]
#   }
# }

manage_aws_auth_configmap = true


aws_auth_roles = [
    {
      rolearn  = module.iam.eks_cluster_role_arn
      username = "terraform"
      groups   = ["system:masters"] #admin group
    },
  ]

aws_auth_users = []

aws_auth_accounts = [
  "529889896938",
]

tags = {
  Environment = "web_app"
  Terraform   = "true"
}
