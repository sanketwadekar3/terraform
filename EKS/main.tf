//Creation of EKS CLuster

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_iam_role.arn

  vpc_config {
    subnet_ids              = var.eks_subnet_ids # Provide a List
    security_group_ids      = [aws_security_group.eks_sg.id]
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  version = var.k8s_version
  tags    = var.tags
}

// Creation of node group for the eks cluster

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name           = aws_eks_cluster.eks_cluster.name
  node_group_name_prefix = var.eks_node_group_name_prefix
  node_role_arn          = aws_iam_role.node_group_iam_role.arn

  scaling_config {
    desired_size = var.node_group_desired_size
    min_size     = var.node_group_min_size
    max_size     = var.node_group_max_size
  }

  capacity_type  = var.node_group_capacity_type
  disk_size      = var.node_group_disk_size
  instance_types = var.node_group_instance_types
  tags           = var.tags
}