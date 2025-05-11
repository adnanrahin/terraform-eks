output "eks_service_role_arn" {
  value       = aws_iam_role.eks_service.arn
  description = "ARN of the EKS service role"
}
