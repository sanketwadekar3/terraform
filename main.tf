module "VPC" {
  source = "./VPC"
}

module "EKS" {
  source = "./EKS"

  eks_cluster_name           = var.eks_cluster_name
  eks_subnet_ids             = [module.VPC.subnet_ids]
  endpoint_private_access    = var.endpoint_private_access
  endpoint_public_access     = var.endpoint_public_access
  k8s_version                = var.k8s_version
  eks_node_group_name_prefix = var.eks_node_group_name_prefix
  node_group_desired_size    = var.node_group_desired_size
  node_group_min_size        = var.node_group_min_size
  node_group_max_size        = var.node_group_max_size
  node_group_capacity_type   = var.node_group_capacity_type
  node_group_disk_size       = var.node_group_disk_size
  node_group_instance_types  = var.node_group_instance_types
  eks_cluster_iam_role       = var.eks_cluster_iam_role
  node_group_iam_role        = var.node_group_iam_role
  eks_sg_name                = var.eks_sg_name
  port                       = var.eks_sg_port
  protocol                   = var.eks_sg_protocol
  eks_sg_cidr                = var.eks_sg_cidr
}