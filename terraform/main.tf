terraform {
  backend "s3" {
    bucket = "<バケットネーム>"
    key    = "ecs/wordpress/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {}

module "vpc" {
  source = "../modules/vpc"
}

module "alb" {
  source = "../modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id
  instance1_id = null
  instance2_id = null
}

module "rds" {
  source = "../modules/rds"
  vpc_id = module.vpc.vpc_id
  private_subnet1_id = module.vpc.private_subnet1_id
  private_subnet2_id = module.vpc.private_subnet2_id
}

module "cloudfront" {
  source = "../modules/cloudfront"
  alb_dns = module.alb.alb_dns
}

module "route53" {
  source = "../modules/route53"
  cloudfront_dns = module.cloudfront.cloudfront_dns
}

module "ecs" {
  source = "../modules/ecs"
  vpc_id            = module.vpc.vpc_id
  public_subnet1_id = module.vpc.public_subnet1_id
  public_subnet2_id = module.vpc.public_subnet2_id
  alb_tg            = module.alb.alb_tg
  db_host           = module.rds.db_host
  db_name           = "wordpress"
  db_user           = "admin"
  db_password       = "Password123"
  image_tag = var.image_tag
}