variable "replication_instance_name" {
  type        = string
  description = "DMS Replication instance name"
}

variable "replication_instance_class" {
  type        = string
  description = "DMS replication instance class"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "VPC security group IDs for DMS Replication instance"
}

variable "engine_version" {
  type        = string
  description = "Engine version of DMS Replication Instance"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage for DMS Replication instance"
  default     = 50
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Allow major version upgrade or not"
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Auto upgrade minor version for DMS Replication instance"
  default     = false
}

variable "multi_az" {
  type        = bool
  description = "Multi AZ setup for DMS Replication instance"
  default     = false
}

variable "preferred_maintenance_window" {
  type        = string
  description = "Preferred maintenance window for DMS Replication instance"
  default     = "sun:19:30-sun:23:30"
}

variable "publicly_accessible" {
  type        = bool
  description = "Public accessibility for DMS Replication instance"
  default     = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to create a subnet group for DMS replication instance"
}

variable "tags" {

}

variable "common_tags" {

}