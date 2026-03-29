locals {

    ami_id = data.aws_ami.openvpn.id

    
    common_tags={

    Project = var.project
    Environment = var.environment
    Terraform = "true"
    }

    # public subnet id from 1a zone is used for bastion host because it is used for public facing resources and it is more available than other zones. so we are using public subnet id from 1a zone for bastion host. we are fetching it from SSM Parameter Store where we have stored the public subnet id for each environment.

    public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

    openvpn_sg_id = data.aws_ssm_parameter.openvpn_sg_id.value
}