data "aws_ami" "joindevops" {
  most_recent      = true
  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Fetching the public subnet ID from SSM Parameter Store to use it in the aws_instance resource for the bastion host. we should not use default public subnet id because it may change in different environments. so we are fetching it from SSM Parameter Store where we have stored the public subnet id for each environment.    

# both of below snippets are fetching from data source
data "aws_ssm_parameter" "database_subnet_ids" {
  name = "/${var.project}/${var.environment}/database_subnet_ids"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project}/${var.environment}/mongodb_sg_id"  
}

data "aws_ssm_parameter" "redis_sg_id" {
  name = "/${var.project}/${var.environment}/redis_sg_id"  
}