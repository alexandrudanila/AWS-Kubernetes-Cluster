variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "cluster_name" {
  type    = string
  default = "eks-lab"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_name" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "role_name" {
  description = "IAM role name for the EKS admin EC2"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name for the EKS admin EC2"
  type        = string
}

variable "admin_ip" {
  description = "Public IP allowed to SSH to the admin EC2"
  type        = string
}
variable "vpc_cidr" {
  type    = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "vpc_name" {
  type    = string
  default = "k8s-cluster-vpc"
}
variable "sg_name" {
  description = "Name of the Security Group for EKS admin host"
  type        = string
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
