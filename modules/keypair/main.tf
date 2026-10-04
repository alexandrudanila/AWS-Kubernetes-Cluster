resource "tls_private_key" "eks_admin" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "eks_admin" {
  key_name   = var.key_name
  public_key = tls_private_key.eks_admin.public_key_openssh

  tags = {
    Name = var.key_name
  }
}

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.eks_admin.private_key_pem
  filename        = "${path.root}/${var.key_name}.pem"
  file_permission = "0600"
}