data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}


resource "aws_instance" "eks_admin" {
  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = var.iam_instance_profile

  key_name = var.key_name

  user_data = templatefile(
    "${path.module}/script.sh",
    {
      cluster_name       = var.cluster_name
      nodegroup_name     = var.nodegroup_name
      node_type          = var.node_type
      desired_nodes      = var.desired_nodes
      min_nodes          = var.min_nodes
      max_nodes          = var.max_nodes
      kubernetes_version = var.kubernetes_version
      aws_region         = var.aws_region
    }
  )

  tags = {
    Name = var.instance_name
  }
}