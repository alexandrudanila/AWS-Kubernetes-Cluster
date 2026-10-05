output "vpc_id" {
  description = "VPC ID used by EKS"
  value       = module.network.vpc_id
}

output "eks_subnet_ids" {
  description = "Subnet IDs used by EKS"
  value       = module.network.eks_subnet_ids
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_nodegroup_name" {
  value = module.eks.nodegroup_name
}