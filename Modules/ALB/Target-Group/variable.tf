/*
    Variables
*/

variable "vpc" {
    description = "ALB Target Group - VPC"
    type        = any
}

variable "target_groups" {
    description = "ALB Target Group - Target Groups"
    type        = list
}

variable "tags" {
    description   = "ALB Target Group - Tags"
    type          = any
}