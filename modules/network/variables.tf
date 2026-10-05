variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "eks_subnet_cidrs" {
  type = list(string)
}