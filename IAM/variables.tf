variable "role_name" {
  type        = string
  description = "Name of the IAM Role."
}

variable "policy_name" {
  type        = string
  description = "Name of the IAM policy."
}

variable "policy_filepath" {
  type        = string
  description = "filepath of iam policy"
}

variable "allowed_services_for_assume_role" {
  type        = list(string)
  description = "Allowed services for assume role."
}

variable "tags" {

}

variable "common_tags" {

}