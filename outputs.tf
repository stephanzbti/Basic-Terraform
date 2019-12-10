/*
    Outputs
*/

variable "alb_dns" {
    value   = module.alb.dns_name
}
