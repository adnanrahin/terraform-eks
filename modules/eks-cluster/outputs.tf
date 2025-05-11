output "arn" {
  value       = aws_eks_cluster.main.arn
  description = "ARN of the EKS cluster"
}

output "certificate_authority_data" {
  value       = aws_eks_cluster.main.certificate_authority[0].data
  description = "Certificate authority data for the cluster"
}

output "cluster_security_group_id" {
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
  description = "Security group ID associated with the cluster"
}

output "endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "Endpoint for the EKS cluster"
}
