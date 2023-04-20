// Variables for EKS Cluster

variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
}

variable "eks_subnet_ids" {
  type        = list(string)
  description = "List of eks subnet ids"
}

variable "endpoint_private_access" {
  type        = bool
  description = "Provide True for private access otherwise False."
}

variable "endpoint_public_access" {
  type        = bool
  description = "Provide True for public access otherwise False."
}

variable "k8s_version" {
  type        = string
  description = "K8s version"
}

variable "tags" {

}

// Variables for EKS node group

variable "eks_node_group_name_prefix" {
  type        = string
  description = "EKS node group name prefix"
}

variable "node_group_desired_size" {
  type        = number
  description = "Desired size for the node group instances."
}

variable "node_group_min_size" {
  type        = number
  description = "Minimum size for the node group instances."
}

variable "node_group_max_size" {
  type        = number
  description = "Maximum size for the node group instances."
}

variable "node_group_capacity_type" {
  type        = string
  description = "Capacity type for node group instances."
}

variable "node_group_disk_size" {
  type        = number
  description = "Disk size of node group instances."
}

variable "node_group_instance_types" {
  type        = string
  description = "Node group instance type."
}

// Variables for IAM roles

variable "eks_cluster_iam_role" {
  type        = string
  description = "EKS cluster iam role name."
}

variable "node_group_iam_role" {
  type        = string
  description = "EKS Node group iam role name."
}

// Variables for EKS security group

variable "eks_sg_name" {
  type        = string
  description = "Name of the EKS security group."
}

variable "port" {
  type        = number
  description = "Port number to be opened for security group."
  default     = 443
}

variable "protocol" {
  type        = string
  description = "Protocol for the security group."
  default     = "tcp"
}

variable "eks_sg_cidr" {
  type        = list(string)
  description = "CIDR block for EKS security group."
}