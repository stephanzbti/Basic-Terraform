/*
    Variables
*/

variable "tags" {
  description = "Instance - Tags"
  type        = any
}

variable "ec2" {
  description = "Instance - AMI"
  type        = list
}