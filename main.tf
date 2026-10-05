module "network" {
  source = "./modules/network"

  vpc_name         = var.vpc_name
  vpc_cidr         = var.vpc_cidr
  eks_subnet_cidrs = var.eks_subnet_cidrs
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version

  subnet_ids = module.network.eks_subnet_ids

  nodegroup_name = var.nodegroup_name
  node_type      = var.node_type

  desired_nodes = var.desired_nodes
  min_nodes     = var.min_nodes
  max_nodes     = var.max_nodes
  admin_role_arn = var.admin_role_arn

}