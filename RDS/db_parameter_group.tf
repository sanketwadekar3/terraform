resource "aws_db_parameter_group" "db_parameter_group" {
  name        = "${var.cluster_name}-db-parameter-group"
  family      = "aurora-postgresql14"
  description = "DB custom parameter group"

}

