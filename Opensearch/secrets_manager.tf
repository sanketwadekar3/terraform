resource "random_string" "username" {
  length  = 8
  lower   = true
  upper   = false
  numeric = false
  special = false
}

resource "random_password" "password" {
  length           = 12
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  override_special = "!#$%&*"
}

resource "aws_secretsmanager_secret" "opensearch_secret" {
  name                    = "${var.domain_name}-secrets"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "opensearch_secret_version" {
  secret_id = aws_secretsmanager_secret.opensearch_secret.id
  secret_string = jsonencode({
    username = "${random_string.username.result}"
    password = "${random_password.password.result}"
  })
  lifecycle {
    ignore_changes = all
  }
}

data "aws_secretsmanager_secret_version" "opensearch_secret" {
  secret_id  = aws_secretsmanager_secret.opensearch_secret.id
  depends_on = [aws_secretsmanager_secret_version.opensearch_secret_version]
}