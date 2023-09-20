resource "random_string" "username" {
  length  = 8
  lower   = true
  upper   = false
  numeric = false
  special = false
  lifecycle {
    ignore_changes = all
  }
}

resource "random_password" "password" {
  length           = 30
  lower            = true
  upper            = true
  numeric          = true
  special          = true
  override_special = "!#%&*"
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_secretsmanager_secret" "db_secret" {
  name                    = "${var.cluster_name}-secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_secret_version" {
  secret_id = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = "${random_string.username.result}"
    password = "${random_password.password.result}"
  })
  lifecycle {
    ignore_changes = all
  }
}

data "aws_secretsmanager_secret_version" "db_secret" {
  secret_id  = aws_secretsmanager_secret.db_secret.id
  depends_on = [aws_secretsmanager_secret_version.db_secret_version]
}