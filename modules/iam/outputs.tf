output "instance_profile_name" {
  description = "IAM instance profile name for the EKS admin EC2"
  value       = aws_iam_instance_profile.eks_admin.name
}

output "role_name" {
  description = "IAM role name for the EKS admin EC2"
  value       = aws_iam_role.eks_admin.name
}

output "role_arn" {
  description = "IAM role ARN for the EKS admin EC2"
  value       = aws_iam_role.eks_admin.arn
}