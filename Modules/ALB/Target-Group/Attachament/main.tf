/*
    Resources
*/

resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
    count               = length(var.ec2)

    target_group_arn    = var.ec2[count.index][0]
    target_id           = var.ec2[count.index][1]
    port                = var.ec2[count.index][2]
}
