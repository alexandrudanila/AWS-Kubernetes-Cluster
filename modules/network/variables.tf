variable "admin_ip" {
  description = "Public IP allowed to SSH to the EKS admin host"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}
variable "public_subnet_cidr" {
  type = string
}

variable "sg_name" {
  description = "Name of the Security Group for the EKS admin host"
  type        = string
}