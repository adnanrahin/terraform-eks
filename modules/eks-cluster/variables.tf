variable "stack_name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the cluster will be created"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "eks_service_role_arn" {
  description = "ARN of the IAM role for EKS service"
  type        = string
}

variable "control_plane_sg_id" {
  description = "Control plane security group ID"
  type        = string
}
