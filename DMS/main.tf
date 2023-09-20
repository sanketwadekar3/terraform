resource "aws_dms_replication_subnet_group" "dms_replication_subnet_group" {
  replication_subnet_group_description = "Subnet group for DMS Replication Instance"
  replication_subnet_group_id          = "${var.replication_instance_name}-subnet-group"
  subnet_ids                           = var.subnet_ids
  tags                                 = (merge(var.tags, var.common_tags))
}

resource "aws_dms_replication_instance" "dms_replication_instance" {
  replication_instance_id      = var.replication_instance_name
  replication_instance_class   = var.replication_instance_class
  replication_subnet_group_id  = aws_dms_replication_subnet_group.dms_replication_subnet_group.id
  vpc_security_group_ids       = var.vpc_security_group_ids
  allocated_storage            = var.allocated_storage
  allow_major_version_upgrade  = var.allow_major_version_upgrade
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  engine_version               = var.engine_version
  multi_az                     = var.multi_az
  preferred_maintenance_window = var.preferred_maintenance_window
  publicly_accessible          = var.publicly_accessible
  tags                         = (merge(var.tags, var.common_tags))
}