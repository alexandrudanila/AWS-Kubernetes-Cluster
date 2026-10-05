output "vpc_id" {
  value = aws_vpc.main.id
}

output "eks_subnet_ids" {
  value = aws_subnet.eks[*].id
}

output "eks_subnet_cidrs" {
  value = aws_subnet.eks[*].cidr_block
}