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
        Developer       = "Stephan Zandona Bartkowiak"
        Date            = "09/12/2019"
        Project         = "Basic Terraform - 2019"
        Environment     = "Development"
    }
    cidr_block          = "10.0.0.0/16"
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
    ingress         = [[ 80, 80, "tcp", ["0.0.0.0/0"]], [ 443, 443, "tcp", ["0.0.0.0/0"]]]
    egress          = [[ 0, 0, "-1", ["0.0.0.0/0"]], [ 0, 0, "-1", ["0.0.0.0/0"]]]

    tags            = local.tags
}

module "security_ec2" {
    source          = "./Modules/VPC/Security-Groups"

    vpc             = module.vpc.vpc
    ingress         = [[ 80, 80, "tcp", [module.vpc.vpc.cidr_block]], [ 443, 443, "tcp", [module.vpc.vpc.cidr_block]]]
    egress          = [[ 0, 0, "-1", [module.vpc.vpc.cidr_block]], [ 0, 0, "-1", [module.vpc.vpc.cidr_block]]]

    tags            = local.tags
}

/*
    ALB
*/

module "alb" {
    source          = "./Modules/ALB"

    security_group  = module.security_loadbalanecer.security_group
    subnets         = module.subnets.subnet_public
    tags            = local.tags
}

module "target_groups" {
    source          = "./Modules/ALB/Target-Group"

    vpc             = module.vpc.vpc
    target_groups   = [[80, "HTTP"], [80, "HTTP"]]
    tags            = local.tags
}

module "listeners" {
    source            = "./Modules/ALB/Listener"

    alb               = module.alb.alb
    listener          = [[80, "HTTP", "forward", module.target_groups.target_groups[0].arn], [443, "HTTP", "forward", module.target_groups.target_groups[1].arn]]
}

module "target_group_attachment" {
    source            = "./Modules/ALB/Target-Group/Attachament"
    
    ec2               = [[module.target_groups.target_groups[0].arn, module.ec2.ec2[0].id, 80], [module.target_groups.target_groups[1].arn, module.ec2.ec2[1].id, 80]]
}

/*
    EC2
*/

module "ec2" {
    source          = "./Modules/EC2"

    ec2             = [["ami-0e926d96c57242e18", "t3.micro", module.security_ec2.security_group.*.id, module.subnets.subnet_private[0].id], ["ami-02d8b9d64843f26c4", "t3.micro", module.security_ec2.security_group.*.id, module.subnets.subnet_private[0].id]]
    tags            = local.tags
}