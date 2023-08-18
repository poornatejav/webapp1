region = "us-east-1"
project = "EKS"
instance_type = "t2.micro"
vpc_cidr = "10.0.0.0/16"
public_cidr = ["10.0.1.0/24"]
private_cidr = ["10.0.2.0/24","10.0.3.0/24"]
ingressrules = [80,22]
egressrules = [0]
cluster_name = "eks_cluster"
private_access = true
eks_cluster_policy_attachment = [
  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
]

eks_node_policy_attachment = [
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
]
node_desired_size = 1
node_max_size = 3
node_min_size = 1
key_name = "web-app-key"
public_key = "/Users/poornateja/.ssh/web-app-key.pub"