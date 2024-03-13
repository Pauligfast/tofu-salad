provider "aws" {
  region = var.region
}

module "vpc" {
  source                = "../../modules/vpc"
  vpc_cidr_block = "10.0.0.0/16"
}

module "subnets" {
  source                    = "../../modules/subnets"
  vpc_id = module.vpc.vpc_id
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  route_table_id = module.vpc.route_table_id
}

module "ec2" {
  source = "../../modules/ec2"
  public_subnet_ids = module.subnets.public_subnet_ids
  security_group_id = module.vpc.security_group_id  
  vpc_id = module.vpc.vpc_id
}
