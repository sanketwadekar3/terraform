variable "bucket_name" {
  type        = string
  description = "Name of the s3 bucket"
}

variable "object_lock_enabled" {
  type        = bool
  description = "Whether to enable s3 object lock or not"
  default     = false
}

variable "block_public_acls" {
  type    = bool
  default = true
}

variable "block_public_policy" {
  type    = bool
  default = true
}

variable "ignore_public_acls" {
  type    = bool
  default = true
}

variable "restrict_public_buckets" {
  type    = bool
  default = true
}

variable "versioning_status" {
  type        = string
  description = "S3 bucket versioning status"
  default     = "Disabled"
}

variable "tags" {

}

variable "common_tags" {

}