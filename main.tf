module "network" {
  source = "./modules/network"

  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  vpc_name = var.vpc_name
  sg_name  = var.sg_name
  admin_ip = var.admin_ip
}

module "iam" {
  source = "./modules/iam"

  role_name             = var.role_name
  instance_profile_name = var.instance_profile_name
}
module "keypair" {
  source = "./modules/keypair"

  key_name = var.key_name
}

module "ec2" {
  source = "./modules/ec2"

  instance_type     = var.instance_type
  subnet_id         = module.network.public_subnet_id
  security_group_id = module.network.security_group_id

  # Output IAM -> Input EC2
  iam_instance_profile = module.iam.instance_profile_name

  key_name      = module.keypair.key_name
  instance_name = var.instance_name

  cluster_name       = var.cluster_name
  nodegroup_name     = var.nodegroup_name
  node_type          = var.node_type
  desired_nodes      = var.desired_nodes
  min_nodes          = var.min_nodes
  max_nodes          = var.max_nodes
  kubernetes_version = var.kubernetes_version
  aws_region         = var.aws_region
}