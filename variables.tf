variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "cluster_name" {
  type = string
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

variable "kubernetes_version" {
  type = string
}

variable "eks_subnet_cidrs" {
  description = "CIDR blocks for EKS subnets in different Availability Zones"
  type        = list(string)
}
variable "admin_role_arn" {
  description = "IAM Identity Center administrator role ARN"
  type        = string
}