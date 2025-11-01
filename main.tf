data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source            = "github.com/Tushar-Sharma10/terraform-aws-2tier-architecture.git//modules/vpc?ref=main"
  availability_zone = data.aws_availability_zones.available.names
  public_cidr       = var.public_cidr
  private_cidr      = var.private_cidr
  project_name      = var.project_name
  environment       = var.environment
}

module "security_group" {
  source = "github.com/Tushar-Sharma10/terraform-aws-2tier-architecture.git//modules/security-group?ref=main"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source         = "github.com/Tushar-Sharma10/terraform-aws-2tier-architecture.git//modules/alb?ref=main"
  vpc_id         = module.vpc.vpc_id
  project_name   = var.project_name
  environment    = var.environment
  target_type    = var.target_type
  security_group = [module.security_group.public_sg_id]
  subnets        = module.vpc.public_subnets_ids
}