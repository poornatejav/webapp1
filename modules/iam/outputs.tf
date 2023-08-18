output "eks_cluster_policy_attachment" {
  value = aws_iam_role_policy_attachment.eks_cluster_policies[*].id
}

output "eks_node_policy_attachment" {
  value = aws_iam_role_policy_attachment.node_policies[*].id
}

output "eks_cluster_instance_profile" {
  value = aws_iam_instance_profile.eks_cluster_instance_profile.name
}

output "eks_node_instance_profile" {
  value = aws_iam_instance_profile.eks_node_instance_profile.name
}

output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
  
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node.arn
}