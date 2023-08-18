output "eks_cluster_name" {
  value       = aws_eks_cluster.eks_cluster.name
}

output "eks_node_group_name" {
  value       = aws_eks_node_group.eks_node.node_group_name
}

output "eks_node_iam_role_arn" {
  value = aws_eks_node_group.eks_node.node_role_arn
}