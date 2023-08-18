resource "aws_iam_role" "eks_cluster" {
  name = "terraform-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "eks_node" {
  name = "terraform-eks-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


resource "aws_iam_role_policy_attachment" "eks_cluster_policies" {
  count      = length(var.eks_cluster_policy_attachment)
  role       = aws_iam_role.eks_cluster.name
  policy_arn = var.eks_cluster_policy_attachment[count.index]
}

resource "aws_iam_role_policy_attachment" "node_policies" {
  count      = length(var.eks_node_policy_attachment)
  role       = aws_iam_role.eks_node.name
  policy_arn = var.eks_node_policy_attachment[count.index]
}

resource "aws_iam_instance_profile" "eks_cluster_instance_profile" {
  name = "eks-cluster-instance-profile"
  role = aws_iam_role.eks_cluster.name
}

resource "aws_iam_instance_profile" "eks_node_instance_profile" {
  name = "eks-node-instance-profile"
  role = aws_iam_role.eks_node.name
}
