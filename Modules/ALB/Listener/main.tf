
resource "aws_lb_listener" "lb_listener" {
    count               = length(var.listener)

    load_balancer_arn   = var.alb.arn
    port                = var.listener[count.index][0]
    protocol            = var.listener[count.index][1]

    default_action {
        type             = var.listener[count.index][2]
        target_group_arn = var.listener[count.index][3]
    }
}