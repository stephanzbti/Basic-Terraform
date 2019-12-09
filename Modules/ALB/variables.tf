/*
    Variables
*/

variable "tags" {
    description = "ALB - Tag"
    type        = any
}

variable "security_group" {
    description = "ALB - Security Group"
    type        = any
}

variable "subnets" {
    description = "ALB - Subnets"
    type        = any
}