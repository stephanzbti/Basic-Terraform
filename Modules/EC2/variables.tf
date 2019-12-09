/*
    Variables
*/

variable "tags" {
  description = "Instance - Tags"
  type        = any
}

variable "ami_id" {
  description = "Instance - AMI"
  type        = string
}

variable "instance_type" {
  description = "Instance - Type"
  type        = string
}