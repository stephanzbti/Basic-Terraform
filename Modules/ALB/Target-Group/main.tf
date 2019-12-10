/*
    Resources
*/

resource "aws_lb_target_group" "lb_target_group" {
    count    = length(var.target_groups)

    port     = var.target_groups[count.index][0]
    protocol = var.target_groups[count.index][1]
    vpc_id   = var.vpc.id

    tags     = var.tags
}