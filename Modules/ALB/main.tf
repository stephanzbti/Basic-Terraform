/*
    Resources
*/

resource "aws_lb" "alb" {
    internal           = false
    load_balancer_type = "application"
    security_groups    = var.security_group.*.id
    subnets            = var.subnets.*.id

    tags = var.tags
}