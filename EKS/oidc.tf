data "tls_certificate" "tls_certificate" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.tls_certificate.certificates[*].sha1_fingerprint
  url             = data.tls_certificate.tls_certificate.url
}