variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "nodegroup_name" {
  type = string
}

variable "node_type" {
  type = string
}

variable "desired_nodes" {
  type = number
}

variable "min_nodes" {
  type = number
}

variable "max_nodes" {
  type = number
}

variable "admin_role_arn" {
  description = "IAM role ARN used by the administrator through AWS IAM Identity Center"
  type        = string
}