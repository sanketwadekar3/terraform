resource "aws_rds_cluster_parameter_group" "rds_cluster_parameter_group" {
  name        = "${var.cluster_name}-rds-cluster-parameter-group"
  family      = "aurora-postgresql14"
  description = "RDS custom cluster parameter group"

}