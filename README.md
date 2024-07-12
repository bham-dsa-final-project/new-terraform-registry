# new-terraform-registry

# Terraform config:

project-root/
├── .github/
│ └── workflows/
│ └── terraform.yml
├── modules/
│ ├── vpc.tf
│ ├── s3.tf
│ ├── dynamodb.tf
│ ├── rds.tf
│ ├── fargate.tf
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars (optional)

# Explanation of the config:

Project Root Directory (new-terraform-registry/)

This is the main directory containing all your Terraform configuration files and the GitHub Actions workflow.

.github/workflows/terraform.yml: This file defines your GitHub Actions workflow. It outlines the steps to automatically run Terraform whenever you push code changes to your GitHub repository or create pull requests.

main.tf: This is the primary Terraform configuration file. It orchestrates the use of your modules, passes variables to them, and sets up any additional resources or configurations needed for your infrastructure.

variables.tf: This file declares the input variables for your Terraform configuration. You use variables to parameterize your infrastructure, making it more flexible and reusable.

outputs.tf: This file defines the output values you want Terraform to display after it applies your configuration. These can be things like resource IDs, URLs, or other important values you might need to access later.

terraform.tfvars (Optional): This file is used to store environment-specific variables that should not be committed to version control (e.g., AWS credentials, passwords). Terraform will automatically load values from this file.

Modules Directory (modules/)

This directory contains your Terraform modules, each in its own file.

vpc.tf: Defines the configuration for your VPC (Virtual Private Cloud). It includes the CIDR block, subnets, and other VPC-related resources.
s3.tf: Sets up the S3 bucket for storing your Terraform state file.
dynamodb.tf: Creates a DynamoDB table to manage state locking for concurrent Terraform operations.
rds.tf: Configures your RDS (Relational Database Service) instance, including the database type, size, and credentials.
fargate.tf: Defines your Fargate service, including the task definition (container image, resources), networking, and scaling parameters.
Each of these module files would contain:

Module Source: Specifies the source of the module (e.g., hashicorp/vpc/aws).
Input Variables: Declares the variables that the module expects to receive as input (e.g., vpc_name, vpc_cidr_block).
Resource Definitions: The actual Terraform code that creates and manages the infrastructure resources within the module.
Output Values: Defines the values that the module will output after it is applied (e.g., vpc_id, rds_endpoint).
