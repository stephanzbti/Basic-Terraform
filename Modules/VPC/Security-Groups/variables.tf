/*
    Variables
*/

variable "vpc" {
    description   = "Security Group - VPC"
    type          = any
}

variable "ingress_from_port" {
    description   = "Security Group - Ingress From port"
    type          = number
}

variable "ingress_to_port" {
    description   = "Security Group - Ingress To Port"
    type          = number
}

variable "ingress_protocol" {
    description   = "Security Group - Ingress Protocol"
    type          = string
}

variable "ingress_cidr_block" {
    description   = "Security Group - Ingress CIDR Block"
    type          = list
}

variable "egress_from_port" {
    description   = "Security Group - Egress From port"
    type          = number
}

variable "egress_to_port" {
    description   = "Security Group - Egress To Port"
    type          = number
}

variable "egress_protocol" {
    description   = "Security Group - Egress Protocol"
    type          = string
}

variable "egress_cidr_block" {
    description   = "Security Group - Egress CIDR Block"
    type          = list
}

variable "tags" {
    description   = "Internet Gateway - Tags"
    type          = any
}