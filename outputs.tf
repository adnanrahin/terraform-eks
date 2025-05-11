output "arn" {
  value       = module.eks_cluster.arn
  description = "ARN of the EKS cluster"
}

output "certificate_authority_data" {
  value       = module.eks_cluster.certificate_authority_data
  description = "Certificate authority data for the cluster"
}

output "cluster_security_group_id" {
  value       = module.eks_cluster.cluster_security_group_id
  description = "Security group ID associated with the cluster"
}

output "endpoint" {
  value       = module.eks_cluster.endpoint
  description = "Endpoint for the EKS cluster"
}

output "security_group" {
  value       = module.security_groups.control_plane_sg_id
  description = "Control plane security group ID"
}

output "service_role_arn" {
  value       = module.iam.eks_service_role_arn
  description = "ARN of the EKS service role"
}

output "shared_node_security_group" {
  value       = module.security_groups.cluster_shared_node_sg_id
  description = "Shared node security group ID"
}

output "subnets_private" {
  value       = module.vpc.private_subnet_ids
  description = "List of private subnet IDs"
}

output "subnets_public" {
  value       = module.vpc.public_subnet_ids
  description = "List of public subnet IDs"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}
