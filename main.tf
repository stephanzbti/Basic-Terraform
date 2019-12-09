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

module "vpc" {
    source        = "./Modules/VPC/"

    cidr_block    = local.cidr_block
    tags          = local.tags
}

module "igw" {
    source        = "./Modules/VPC/Internet-Gateway"

    vpc           = module.vpc.vpc  
    tags          = local.tags
}

module subnets {
    source        = "./Modules/VPC/Subnets"

    vpc           = module.vpc.vpc
    igw           = module.igw.igw
    tags          = local.tags
}