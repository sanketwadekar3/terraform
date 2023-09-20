variable "cluster_name" {
  type        = string
  description = "Name of the RDS cluster."
}

variable "engine" {
  type        = string
  description = "RDS Engine"
}

variable "engine_mode" {
  type        = string
  description = "RDS Engine mode"
}

variable "engine_version" {
  type        = string
  description = "RDS engine version"
}

variable "database_name" {
  type        = string
  description = "Database name in RDS"
}

variable "port" {
  type        = number
  description = "Port number for RDS"
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention period for RDS"
}

variable "preferred_backup_window" {
  type        = string
  description = "Preferred backup window for RDS"
}

variable "deletion_protection" {
  type        = bool
  description = "Deletion protection for RDS cluster"
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  type        = set(string)
  description = "Log level enabled for cloudwatch logs exports"
  default     = ["postgresql"]
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "VPC security group ids for RDS"
}

variable "scaling_configuration" {

}

variable "serverlessv2_scaling_configuration" {

}

variable "instance_class" {
  type        = string
  description = "Instance class for RDS"
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Auto minor version upgrade for cluster instance (True or False)"
  default     = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to create DB subnet group"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot while deleting RDS cluster"
  default     = true
}

variable "final_snapshot_identifier" {
  default = null
}

variable "snapshot_identifier" {
  default = null
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "tags" {

}

variable "common_tags" {

}