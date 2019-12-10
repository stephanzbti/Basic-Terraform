/*
  Output Values
*/

output "target_groups" {
  value       = aws_lb_target_group.lb_target_group
  description = "ALB - Target Groups"
}