output "oidc_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_id" {
  value = aws_eks_cluster.eks_cluster.id
}

output "aws_auth_map_role" {
  value = [
    {
      rolearn  = "${aws_iam_role.node_group_iam_role.arn}"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    }
  ]
}