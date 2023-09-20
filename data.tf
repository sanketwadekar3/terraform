data "aws_eks_cluster" "cluster" {
  name = module.EKS.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.EKS.cluster_id
}