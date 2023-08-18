resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.role_arn

  vpc_config {
    security_group_ids = var.security_group_id
    subnet_ids       = var.subnet_id
    endpoint_private_access = var.private_access

  }

}
 

resource "aws_eks_node_group" "eks_node" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "Eks_node"
  node_role_arn   = var.eks_node_arn
  subnet_ids      = var.subnet_id
  instance_types = [var.instance_type]


  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  
}

