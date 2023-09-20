resource "aws_kms_key" "eks_encrypt_secret" {
  description         = "KMS Key for EKS Secrets encryption"
  enable_key_rotation = true
}