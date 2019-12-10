/*
    Variables
*/

variable "alb" {
    description = "ALB Listerner - ALB"
    type        = any
}

variable "listener" {
    description = "ALB Listener - Listener"
    type        = list
}