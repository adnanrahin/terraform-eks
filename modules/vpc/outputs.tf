output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = [aws_subnet.public_useast1a.id, aws_subnet.public_useast1c.id]
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = [aws_subnet.private_useast1a.id, aws_subnet.private_useast1c.id]
  description = "List of private subnet IDs"
}
