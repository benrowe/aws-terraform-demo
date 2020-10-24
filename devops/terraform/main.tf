locals {
  tags = {
    Environment = var.environment
    Name        = var.stack_name
    Terraform   = "true"
  }
  prefix = "${var.environment}-${var.stack_name}"
}

module "ecr_web" {
  source = "./modules/ecr"
  name   = "${local.prefix}-web"
  tags   = local.tags
}

module "ecr_app" {
  source = "./modules/ecr"
  name   = "${local.prefix}-app"
  tags   = local.tags
}

module "ecr_worker" {
  source = "./modules/ecr"
  name   = "${local.prefix}-worker"
  tags   = local.tags
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.59.0"

  name = "${local.prefix}-vpc"
  cidr = "10.0.0.0/16"

  azs = [
    "${var.AWS_REGION}a",
    "${var.AWS_REGION}b",
    "${var.AWS_REGION}c"
  ]
  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24"
  ]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  //  create_database_subnet_group = false
  tags = local.tags
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "${var.stack_name}-primary"

  engine               = "mariadb"
  engine_version       = "10.4.8"
  family               = "mariadb10.4"
  major_engine_version = "10.4"
  instance_class       = var.db_instance
  allocated_storage    = 5

  name     = var.db_name
  password = var.db_password
  username = var.db_username
  port     = 3306

  multi_az = true

  deletion_protection = true

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  subnet_ids             = module.vpc.database_subnets
  vpc_security_group_ids = module.vpc.database_subnets


  tags = local.tags
}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  name   = "${var.stack_name}-ecs"
  tags   = local.tags
}


//module "ecs-autoscaling" {
//  source = "terraform-aws-modules/autoscaling/aws"
//  version = "~> 3.0"
//
//  name = "something"
//
//  lc_name = "something"
//
//
//  //  tags = local.tags
//}
