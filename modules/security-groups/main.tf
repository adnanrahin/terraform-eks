resource "aws_security_group" "cluster_shared_node" {
  name        = "${var.stack_name}-cluster-shared-node-sg"
  description = "Communication between all nodes in the cluster"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.stack_name}/ClusterSharedNodeSecurityGroup"
  }
}

resource "aws_security_group" "control_plane" {
  name        = "${var.stack_name}-control-plane-sg"
  description = "Communication between the control plane and worker nodegroups"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.stack_name}/ControlPlaneSecurityGroup"
  }
}

resource "aws_security_group_rule" "ingress_default_cluster_to_node" {
  description              = "Allow managed and unmanaged nodes to communicate with each other (all ports)"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.control_plane.id
  security_group_id        = aws_security_group.cluster_shared_node.id
}

resource "aws_security_group_rule" "ingress_inter_node_group" {
  description              = "Allow nodes to communicate with each other (all ports)"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.cluster_shared_node.id
  security_group_id        = aws_security_group.cluster_shared_node.id
}

resource "aws_security_group_rule" "ingress_node_to_default_cluster" {
  description              = "Allow unmanaged nodes to communicate with control plane (all ports)"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = aws_security_group.cluster_shared_node.id
  security_group_id        = aws_security_group.control_plane.id
}
