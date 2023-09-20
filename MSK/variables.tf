variable "cluster_name" {
  type        = string
  description = "Name of the MSK Cluster."
}

variable "kafka_version" {
  type        = string
  description = "Kafka version."
}

variable "number_of_broker_nodes" {
  type        = number
  description = "Number of broker nodes."
}

variable "enhanced_monitoring" {
  type        = string
  description = "Enhanced monitoring"
}

variable "client_subnets" {
  description = "List of client subnets for MSK."
}

variable "broker_instance_type" {
  type        = string
  description = "Instance type for MSK broker."
}

variable "security_groups" {
  description = "List of security groups for MSK."
}

variable "broker_public_access_type" {
  type        = string
  description = "Public access for MSK broker"
  default     = "DISABLED"
}

variable "broker_ebs_volume_size" {
  type        = number
  description = "Volume size for MSK broker ebs volume."
}

variable "client_iam_authentication" {
  type        = bool
  description = "Client IAM Authentication for MSK."
  default     = true
}

variable "tags" {

}

variable "common_tags" {

}