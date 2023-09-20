module "EKS" {
  source = "./EKS"

  cluster_name            = var.EKS["cluster_name"]
  subnet_ids              = var.EKS["subnet_ids"]
  security_group_ids      = var.EKS["security_group_ids"]
  endpoint_private_access = var.EKS["endpoint_private_access"]
  k8s_version             = var.EKS["k8s_version"]
  node_group              = var.EKS["node_group"]
  cluster_iam_role        = var.EKS["cluster_iam_role"]
  node_group_iam_role     = var.EKS["node_group_iam_role"]
  tags                    = var.EKS["tags"]
  common_tags             = var.tags
}

module "EKS_auth" {
  source = "./EKS_auth"

  aws_auth_map_role = module.EKS.aws_auth_map_role
  roles             = var.EKS_auth["roles"]
  users             = var.EKS_auth["users"]
}

module "MSK" {
  source = "./MSK"

  count = var.create_msk_cluster ? 1 : 0

  cluster_name              = var.MSK["cluster_name"]
  kafka_version             = var.MSK["kafka_version"]
  number_of_broker_nodes    = var.MSK["number_of_broker_nodes"]
  enhanced_monitoring       = try(var.MSK["enhanced_monitoring"], null)
  client_subnets            = var.MSK["client_subnets"]
  broker_instance_type      = var.MSK["broker_instance_type"]
  security_groups           = var.MSK["security_groups"]
  broker_public_access_type = var.MSK["broker_public_access_type"]
  broker_ebs_volume_size    = var.MSK["broker_ebs_volume_size"]
  client_iam_authentication = var.MSK["client_iam_authentication"]
  tags                      = var.MSK["tags"]
  common_tags               = var.tags
}

module "RDS" {
  source = "./RDS"

  for_each = var.RDS

  cluster_name                       = each.value.cluster_name
  engine                             = each.value.engine
  engine_mode                        = each.value.engine_mode
  engine_version                     = each.value.engine_version
  database_name                      = each.value.database_name
  port                               = each.value.port
  backup_retention_period            = each.value.backup_retention_period
  preferred_backup_window            = each.value.preferred_backup_window
  vpc_security_group_ids             = each.value.vpc_security_group_ids
  deletion_protection                = each.value.deletion_protection
  scaling_configuration              = each.value.scaling_configuration
  serverlessv2_scaling_configuration = each.value.serverlessv2_scaling_configuration
  instance_count                     = each.value.instance_count
  instance_class                     = each.value.instance_class
  subnet_ids                         = each.value.subnet_ids
  skip_final_snapshot                = try(each.value.skip_final_snapshot, true)
  final_snapshot_identifier          = try(each.value.final_snapshot_identifier, null)
  snapshot_identifier                = try(each.value.snapshot_identifier, null)
  tags                               = each.value.tags
  common_tags                        = var.tags
}

module "IAM" {
  source = "./IAM"

  for_each = var.IAM

  role_name                        = each.value.role_name
  policy_name                      = each.value.policy_name
  policy_filepath                  = each.value.policy_filepath
  allowed_services_for_assume_role = each.value.allowed_services_for_assume_role
  tags                             = each.value.tags
  common_tags                      = var.tags
}

module "IAM_service_account" {
  source = "./IAM_service_account"

  for_each = var.IAM_service_account

  role_name                = each.value.role_name
  policy_name              = try(each.value.policy_name, "")
  policy_filepath          = try(each.value.policy_filepath, "")
  policy_arn               = try(each.value.policy_arn, "")
  k8s_namespace            = each.value.k8s_namespace
  k8s_service_account_name = each.value.k8s_service_account_name
  oidc_arn                 = module.EKS.oidc_arn
  oidc_value               = trimprefix(trimprefix(module.EKS.oidc_arn, element(split("/", module.EKS.oidc_arn), 0)), "/")
  tags                     = each.value.tags
  common_tags              = var.tags
}

module "S3" {
  source = "./S3"

  for_each = var.S3

  bucket_name       = each.value.bucket_name
  versioning_status = each.value.versioning_status
  tags              = each.value.tags
  common_tags       = var.tags
}

module "DMS" {
  source = "./DMS"

  count = var.create_dms ? 1 : 0

  replication_instance_name  = var.DMS["replication_instance_name"]
  replication_instance_class = var.DMS["replication_instance_class"]
  vpc_security_group_ids     = var.DMS["vpc_security_group_ids"]
  engine_version             = var.DMS["engine_version"]
  subnet_ids                 = var.DMS["subnet_ids"]
  tags                       = var.DMS["tags"]
  common_tags                = var.tags
}

module "Opensearch" {
  source = "./Opensearch"

  count = var.create_opensearch ? 1 : 0

  domain_name              = var.Opensearch["domain_name"]
  dedicated_master_count   = try(var.Opensearch["dedicated_master_count"], null)
  dedicated_master_enabled = var.Opensearch["dedicated_master_enabled"]
  dedicated_master_type    = try(var.Opensearch["dedicated_master_type"], null)
  instance_count           = var.Opensearch["instance_count"]
  instance_type            = var.Opensearch["instance_type"]
  engine_version           = var.Opensearch["engine_version"]
  security_group_ids       = var.Opensearch["security_group_ids"]
  subnet_ids               = var.Opensearch["subnet_ids"]
  zone_awareness_enabled   = var.Opensearch["zone_awareness_enabled"]
  zone_awareness_config    = var.Opensearch["zone_awareness_config"]
  volume_size              = var.Opensearch["volume_size"]
  tags                     = var.Opensearch["tags"]
  common_tags              = var.tags
}