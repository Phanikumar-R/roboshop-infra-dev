terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0"   # Terraform aws version
    }
  }

   backend "s3" {
    bucket = "remote-state-daws-88s-dev"  
    key    = "roboshop-dev-components"    # here make sure give unique name for each module
    region = "us-east-1"
    encrypt = true
    use_lockfile = true 
  }

}


provider "aws" {

    region = "us-east-1"
  
}