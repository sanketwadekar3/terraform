//Creation of EKS CLuster

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_iam_role.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = false
  }

  enabled_cluster_log_types = ["api", "authenticator", "audit", "scheduler", "controllerManager"]

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.eks_encrypt_secret.arn
    }
  }

  version = var.k8s_version
  tags    = (merge(var.tags, var.common_tags))
}

// Creation of node group for the eks cluster

resource "aws_eks_node_group" "eks_node_group" {

  for_each = var.node_group

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = each.value.name
  node_role_arn   = aws_iam_role.node_group_iam_role.arn
  subnet_ids      = var.subnet_ids
  ami_type        = each.value.ami_type

  scaling_config {
    desired_size = each.value.desired_size
    min_size     = each.value.min_size
    max_size     = each.value.max_size
  }

  capacity_type  = each.value.capacity_type
  disk_size      = each.value.disk_size
  instance_types = each.value.instance_types
  tags = (merge(var.tags, var.common_tags,
    tomap({
      "nodegroup-name"                                            = "${each.value.name}"
      "k8s.io/cluster-autoscaler/enabled"                         = "true",
      "kubernetes.io/cluster/${aws_eks_cluster.eks_cluster.name}" = "owned"
    })
  ))
}