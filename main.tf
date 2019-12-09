/*
    Backend
*/

terraform {
  backend "s3" {
    bucket         = "terraform-state-files-hotmart"
    key            = "Infraestructure/Development/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-development-locks"
    encrypt        = false
  }
}

/*
    Variables
*/

locals {
    tags = {
        Developer   = "Stephan Zandona Bartkowiak"
        Date        = "09/12/2019"
        Project     = "Basic Terraform - 2019"
        Environment = "Development"
    }
    cidr_block      = "10.0.0.0/16"
}

/*
    Modules
*/


/*
    Networks
*/

module "vpc" {
    source          = "./Modules/VPC/"

    cidr_block      = local.cidr_block
    tags            = local.tags
}

module "igw" {
    source          = "./Modules/VPC/Internet-Gateway"

    vpc             = module.vpc.vpc  
    tags            = local.tags
}

module subnets {
    source          = "./Modules/VPC/Subnets"

    vpc             = module.vpc.vpc
    igw             = module.igw.igw
    tags            = local.tags
}

module "security_loadbalanecer" {
    source          = "./Modules/VPC/Security-Groups"

    vpc             = module.vpc.vpc
    ingress_from_port       = 443
    ingress_to_port         = 443
    ingress_protocol        = "tcp"
    ingress_cidr_block      = ["0.0.0.0/0"]
    egress_from_port        = 0
    egress_to_port          = 0
    egress_protocol         = "-1"
    egress_cidr_block       = ["0.0.0.0/0"]

    tags                = local.tags
}

module "security_loadbalanecer_rule" {
    source          = "./Modules/VPC/Security-Groups/Security-Group-Rule"

    from_port       = 443
    to_port         = 443
    protocol        = "tcp" 
    cidr_block      = ["0.0.0.0/0"]
    security_group  = module.security_loadbalanecer.security_group
}

/*
    ALB
*/

module "ALB" {
    source          = "./Modules/ALB"

    security_group  = module.security_loadbalanecer.security_group
    subnets         = module.subnets.subnet_public
    tags            = local.tags
}
