 resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project}/${var.environment}/vpc_id"
  type  = "String"
  value = module.vpc.vpc_id
}   

 resource "aws_ssm_parameter" "public_subnet_ids" {                # SSM Parameter Store is used to store the output values of the VPC module as parameters that can be accessed by other modules or applications. This allows for better organization and management of infrastructure resources.
  name  = "/${var.project}/${var.environment}/public_subnet_ids"
  type  = "StringList"
  value = join(",", module.vpc.public_subnet_ids)  # Convert the list of public subnet IDs to a comma-separated string for storage in SSM Parameter Store.
}

 resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.environment}/private_subnet_ids"
  type  = "StringList"
  value = join(",", module.vpc.private_subnet_ids)
}

 resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project}/${var.environment}/database_subnet_ids"
  type  = "StringList"
  value = join(",", module.vpc.database_subnet_ids)
}   