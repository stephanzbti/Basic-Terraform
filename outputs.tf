/*
    Outputs
*/

output "alb_dns" {
    value   = module.alb.alb.dns_name
}
