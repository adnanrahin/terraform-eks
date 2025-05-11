variable "stack_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "development-k8s-cluster"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "development-k8s-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.30"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
