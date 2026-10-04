output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "iam_role_arn" {
  value = module.iam.role_arn
}