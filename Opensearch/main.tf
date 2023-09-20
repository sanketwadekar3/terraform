resource "aws_opensearch_domain" "opensearch_domain" {
  domain_name     = var.domain_name
  access_policies = data.aws_iam_policy_document.domain_policy.json

  advanced_options = {
    "override_main_response_version" : "true"
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = jsondecode(data.aws_secretsmanager_secret_version.opensearch_secret.secret_string)["username"]
      master_user_password = jsondecode(data.aws_secretsmanager_secret_version.opensearch_secret.secret_string)["password"]
    }
  }

  cluster_config {
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_type    = var.dedicated_master_type
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    zone_awareness_enabled   = var.zone_awareness_enabled

    dynamic "zone_awareness_config" {
      for_each = var.zone_awareness_enabled == true ? [var.zone_awareness_config] : []

      content {
        availability_zone_count = zone_awareness_config.value.availability_zone_count
      }
    }
  }

  engine_version = var.engine_version

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  encrypt_at_rest {
    enabled = true
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.volume_size
  }

  node_to_node_encryption {
    enabled = true
  }

  vpc_options {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }

  tags = (merge(var.tags, var.common_tags))
}