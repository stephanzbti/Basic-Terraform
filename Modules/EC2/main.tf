/*
    Resources
*/

resource "aws_instance" "instance" {
    count                      = length(var.ec2)

    ami                        = var.ec2[count.index][0]
    instance_type              = var.ec2[count.index][1]
    vpc_security_group_ids     = var.ec2[count.index][2]
    subnet_id                  = var.ec2[count.index][3]

    tags                       = var.tags
    volume_tags                = var.tags
}