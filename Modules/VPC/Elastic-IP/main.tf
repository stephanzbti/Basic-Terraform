/*
    Resources
*/

resource "aws_eip" "eip" {
    vpc             = false
    tags            = var.tags
}
