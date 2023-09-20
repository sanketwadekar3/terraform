data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_kms_key" "cloudwatch_logs" {
  description         = "KMS Key for MSK Cloudwatch logs"
  enable_key_rotation = true
}

resource "aws_cloudwatch_log_group" "msk_logs" {
  name       = "${var.cluster_name}-logs"
  kms_key_id = aws_kms_key.cloudwatch_logs.arn
  depends_on = [aws_kms_key_policy.kms_key_policy]
}

resource "aws_kms_key_policy" "kms_key_policy" {
  key_id = aws_kms_key.cloudwatch_logs.id
  policy = jsonencode({
    Id = "msk_logs_kms_key_policy"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "logs.${data.aws_region.current.name}.amazonaws.com"
        },
        "Action" : [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ],
        "Resource" : "*",
        "Condition" : {
          "ArnEquals" : {
            "kms:EncryptionContext:aws:logs:arn" : "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.cluster_name}-logs"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
}