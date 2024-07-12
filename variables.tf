# AWS Provider
variable "region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1" # Replace with your preferred region
}

# VPC Module
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "List of availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# S3 Module
variable "state_bucket_name" {
  description = "The name of the S3 bucket for storing Terraform state"
  type        = string
  default     = "my-terraform-state-bucket" # Choose a unique bucket name
}


# RDS Module
variable "db_username" {
  description = "The master username for the RDS database"
  type        = string
  default     = "admin"
}


# Fargate Module
variable "project_name" {
  description = "A unique name for the project"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod) to deploy to"
  type        = string
  default     = "dev"
}

variable "docker_image" {
  description = "The Docker image to use for the Fargate task"
  type        = string
}

variable "fargate_cpu" {
  description = "The number of CPU units to allocate to the Fargate task"
  type        = number
  default     = 256
}

variable "fargate_memory" {
  description = "The amount of memory (in MiB) to allocate to the Fargate task"
  type        = number
  default     = 512
}

variable "fargate_desired_count" {
  description = "The desired number of Fargate tasks to run"
  type        = number
  default     = 1
}
