// Variables for EKS Cluster

variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of eks subnet ids"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of eks security group ids"
}

variable "endpoint_private_access" {
  type        = bool
  description = "Provide True for private access otherwise False."
  default     = true
}

# variable "endpoint_public_access" {
#   type        = bool
#   description = "Provide True for public access otherwise False."
#   default     = false
# }

variable "k8s_version" {
  type        = string
  description = "K8s version"
}

variable "tags" {

}

variable "common_tags" {

}

// Variables for EKS node group

variable "node_group" {
  description = "Node group variables"
}

// Variables for IAM roles

variable "cluster_iam_role" {
  type        = string
  description = "EKS cluster iam role name."
}

variable "node_group_iam_role" {
  type        = string
  description = "EKS Node group iam role name."
}