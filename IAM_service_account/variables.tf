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

variable "oidc_arn" {
  type        = string
  description = "ARN of the OIDC provider in EKS."
}

variable "oidc_value" {
  type        = string
  description = "OIDC value coming from EKS."
}

variable "k8s_namespace" {
  type        = string
  description = "EKS Kubernetes namespace for service account."
}

variable "k8s_service_account_name" {
  type        = string
  description = "EKS Kubernetes service account name."
}

variable "policy_arn" {

}

variable "tags" {

}

variable "common_tags" {

}