resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.cluster_name}-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = (merge(var.tags, var.common_tags))
}