output "control_plane_sg_id" {
  value       = aws_security_group.control_plane.id
  description = "Control plane security group ID"
}

output "cluster_shared_node_sg_id" {
  value       = aws_security_group.cluster_shared_node.id
  description = "Cluster shared node security group ID"
}
