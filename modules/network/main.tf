data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "ec2_eks_admin" {
  name        = var.sg_name
  description = "Security group for EKS admin host"
  vpc_id      = aws_vpc.main.id
  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "eks_admin_ssh" {
  security_group_id = aws_security_group.ec2_eks_admin.id

  description = "SSH from administrator IP"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  cidr_ipv4 = var.admin_ip
}

resource "aws_vpc_security_group_egress_rule" "eks_admin_all" {
  security_group_id = aws_security_group.ec2_eks_admin.id

  description = "Allow all outbound traffic"
  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"
}