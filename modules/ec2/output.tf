output "instance_id" {
  value = aws_instance.eks_admin.id
}

output "public_ip" {
  value = aws_instance.eks_admin.public_ip
}

output "public_dns" {
  value = aws_instance.eks_admin.public_dns
}