data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [var.oidc_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_value}:sub"
      values   = ["system:serviceaccount:${var.k8s_namespace}:${var.k8s_service_account_name}"]
    }
    condition {
      test     = "StringEquals"
      variable = "${var.oidc_value}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json
  name               = var.role_name
  tags               = (merge(var.tags, var.common_tags))
}

resource "aws_iam_policy" "iam_policy" {
  count  = var.policy_name == "" ? 0 : 1
  name   = var.policy_name
  policy = file("${var.policy_filepath}")
  tags   = (merge(var.tags, var.common_tags))
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${var.policy_name}-attachement"
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = try(aws_iam_policy.iam_policy[0].arn, var.policy_arn)
}