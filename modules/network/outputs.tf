

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "Security group ID for EKS admin EC2"
  value       = aws_security_group.ec2_eks_admin.id
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}