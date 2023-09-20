#######################################################################
// Variables for provider
#######################################################################

variable "region" {
  type        = string
  description = "AWS region"
}

#######################################################################
// Common Variables
#######################################################################

variable "tags" {

}

variable "create_msk_cluster" {
  type        = bool
  description = "True if you want to create MSK cluster else False"
  default     = true
}

variable "create_dms" {
  type        = bool
  description = "True if you want to create DMS else False"
  default     = false
}

variable "create_opensearch" {
  type        = bool
  description = "True if you want to create DMS else False"
  default     = false
}

#######################################################################
//
#######################################################################

variable "EKS" {

}

variable "EKS_auth" {

}

variable "MSK" {

}

variable "RDS" {

}

variable "IAM" {

}

variable "S3" {

}

variable "IAM_service_account" {

}

variable "DMS" {

}

variable "Opensearch" {

}