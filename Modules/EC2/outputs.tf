/*
  Output Values
*/

output "ec2" {
  value       = aws_instance.instance
  description = "EC2"
}