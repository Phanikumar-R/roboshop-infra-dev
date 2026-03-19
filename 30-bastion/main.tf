resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.public_subnet_id
  vpc_security_group_ids = [local.bastion_sg_id]
  iam_instance_profile = aws_iam_instance_profile.bastion.name 
  #user_data = file("bastion.sh") # we are using user_data to run the bootstrap script to update the /etc/hosts file in all the instances with the private IP address of the database instance. this is required because we are using private IP address to connect to the database instance from other instances. so whenever we launch a new instance then we need to update the /etc/hosts file in all the instances with the private IP address of the database instance. this is required because we are using private IP address to connect to the database instance from other instances. so whenever we launch a new instance then we need to update the /etc/hosts file in all the instances with the private IP address of the database instance.

  /* root_block_device {
    volume_size = 50
    volume_type = "gp3"
    
    #EBS Volume tags
    tags = merge(
      {
        Name = "${var.project}-${var.environment}-bastion"
      },local.common_tags
    )
  } */

  tags = merge (
    

    {
      Name = "${var.project}-${var.environment}-bastion"
    },local.common_tags
  )
}

resource "aws_iam_role" "bastion" {
  name = "RoboshopDevBastion"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge (
    

    {
      Name = "RoboshopDevBastion"
    },local.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "bastion"{
  role       = aws_iam_role.bastion.name
# policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess" # we are attaching AmazonEC2FullAccess policy to bastion host because we want to use bastion host as a jump server to access other resources in the VPC and for that we need AmazonEC2FullAccess policy. in real time scenario we should create a custom policy with least privilege access and attach it to bastion host instead of attaching AmazonEC2FullAccess policy.
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # we are attaching administrator access policy to bastion host because we want to use bastion host as a jump server to access other resources in the VPC and for that we need administrator access policy. in real time scenario we should create a custom policy with least privilege access and attach it to bastion host instead of attaching administrator access policy.
}

#create instance profile for bastion host and attach the role to it. instance profile is a container for an IAM role that you can use to pass an IAM role
resource "aws_iam_instance_profile" "bastion" {
  name = "${var.project}-${var.environment}-bastion"    
  role = aws_iam_role.bastion.name
}