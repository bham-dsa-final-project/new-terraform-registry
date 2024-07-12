terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
  }
  backend "s3" {
    bucket = var.state_bucket_name
    key    = "terraform.tfstate"
    region = var.region
  }
}

provider "aws" {
  region = var.region
}

# VPC Module
module "vpc" {
  source  = "hashicorp/vpc/aws"
  version = "5.3.0"

  name            = var.vpc_name
  cidr_block      = var.vpc_cidr_block
  azs             = ["eu-west-2a", "eu-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# S3 Module
resource "aws_s3_bucket" "state_bucket" {
  bucket = var.state_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}

# DynamoDB Module
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


# RDS Module (Example: Using a module directly from the registry)
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 5.0" # Adjust the version as needed

  identifier        = "mydb"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  # ... other RDS configuration ...
  username               = var.db_username
  password               = random_password.database_password.result
  subnet_ids             = module.vpc.private_subnets
  vpc_security_group_ids = [module.vpc.default_security_group_id]

}

resource "random_password" "database_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Fargate Module (Example: Using a simplified Fargate module)
module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 4.0"

  cluster_name = "my-fargate-cluster"

  # Service Configuration
  service_name = "${var.project_name}-${var.environment}-service"

  # Task Definition Configuration
  task_definition_family = "${var.project_name}-${var.environment}-task-definition"
  container_name         = "${var.project_name}-container"
  container_image        = var.docker_image
  container_cpu          = var.fargate_cpu
  container_memory       = var.fargate_memory
  container_port         = 80

  # Networking Configuration
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.vpc.default_security_group_id]
  assign_public_ip   = false

  # Load Balancer Configuration
  load_balancer_type = "application"
  # ... configure your load balancer and target group ...
}

# Outputs
# ... (Define your outputs as needed)
