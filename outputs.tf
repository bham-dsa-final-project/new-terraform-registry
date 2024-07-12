# VPC Module Outputs
output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "vpc_default_security_group_id" {
  value       = module.vpc.default_security_group_id
  description = "The ID of the default security group for the VPC"
}

output "vpc_private_subnet_ids" {
  value       = module.vpc.private_subnets
  description = "List of IDs of private subnets in the VPC"
}

output "vpc_public_subnet_ids" {
  value       = module.vpc.public_subnets
  description = "List of IDs of public subnets in the VPC"
}

# RDS Module Outputs
output "rds_endpoint" {
  value       = module.rds.db_instance_endpoint
  description = "The endpoint of the RDS database"
}

output "rds_port" {
  value       = module.rds.db_instance_port
  description = "The port of the RDS database"
}

# Fargate Module Outputs
output "ecs_service_url" {
  value       = module.ecs.service_url
  description = "The URL of the ECS service"
}

output "ecs_task_definition_arn" {
  value       = module.ecs.task_definition_arn
  description = "The ARN of the ECS task definition"
}

# S3 Module Outputs (Optional - include if you need the bucket URL for other purposes)
output "s3_bucket_arn" {
  value       = aws_s3_bucket.state_bucket.arn
  description = "The ARN of the S3 bucket"
}

# DynamoDB Module Outputs (Usually not necessary for state locking)
