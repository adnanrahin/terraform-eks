resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.eks_service_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)
    security_group_ids      = [var.control_plane_sg_id]
    endpoint_public_access  = true
    endpoint_private_access = false
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = {
    Name = "${var.stack_name}/ControlPlane"
  }
}
