module "ecr_web" {
  source = "./modules/ecr"
  name = "${var.stack_name}-web"
}

module "ecr_app" {
  source = "./modules/ecr"
  name = "${var.stack_name}-app"
}

module "ecr_worker" {
  source = "./modules/ecr"
  name = "${var.stack_name}-worker"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.59.0"

  name = "vpc-module-demo"
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

  tags = {
    Terraform = "true"
    Environment = "prod"
    Name = var.stack_name
  }
}

module "db" {
  source = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "${var.stack_name}-primary"

  engine = "mariadb"
  engine_version = "10.4.8"
  family = "mariadb10.4"
  major_engine_version = "10.4"
  instance_class = var.db_instance
  allocated_storage = 5

  name = var.db_name
  password = var.db_password
  username = var.db_username
  port = 3306

  multi_az = true

  deletion_protection = true

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window = "03:00-06:00"

  subnet_ids = module.vpc.database_subnets
  vpc_security_group_ids = module.vpc.database_subnets


  tags = {
    Terraform = "true"
    Environment = "dev"
    Name = var.stack_name
  }
}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

}
