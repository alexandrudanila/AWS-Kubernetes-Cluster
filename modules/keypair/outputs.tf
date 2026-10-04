output "key_name" {
  description = "AWS EC2 key pair name"
  value       = aws_key_pair.eks_admin.key_name
}