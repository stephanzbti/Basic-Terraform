/*
    Outputs
*/

output "alb_dns" {
    value   = module.alb.alb.dns_name
}

output "AMI" {
    value   = data.aws_ami.ubuntu
}
