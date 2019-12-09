/*
    Outputs
*/

output "subnet_public" {
  value       = aws_subnet.private
  description = "Subnet - Private"
}

output "subnet_private" {
  value       = aws_subnet.public
  description = "Subnet - Public"
}