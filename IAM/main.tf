data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = var.allowed_services_for_assume_role
    }
  }
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json
  name               = var.role_name
  tags               = (merge(var.tags, var.common_tags))
}

resource "aws_iam_policy" "iam_policy" {
  name   = var.policy_name
  policy = file("${var.policy_filepath}")
  tags   = (merge(var.tags, var.common_tags))
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name       = "${var.policy_name}-attachement"
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = aws_iam_policy.iam_policy.arn
}