resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.mongodb_sg_id]
  #iam_instance_profile = aws_iam_instance_profile.bastion.name  # This is not required for database instance because we are not attaching any policy to it. we are not giving access to it to access any other resource. so we are not attaching any IAM role to it. if we want to attach any IAM role to it in future then we can create a new IAM role and attach it to the instance.

  tags = merge (
    

    {
      Name = "${var.project}-${var.environment}-mongodb"
    },local.common_tags
  )
}

# when instance id is changed as per above snippet below resource will be triggered and it will run the bootstrap-hosts.sh script to update the /etc/hosts file in all the instances with the new private IP address of the database instance. this is required because we are using private IP address to connect to the database instance from other instances. so whenever the private IP address of the database instance is changed then we need to update the /etc/hosts file in all the instances with the new private IP address of the database instance. this is required because we are using private IP address to connect to the database instance from other instances. so whenever the private IP address of the database instance is changed then we need to update the /etc/hosts file in all the instances with the new private IP address of the database instance.
resource "terraform_data" "bootstrap" {
  triggers_replace = [
    aws_instance.mongodb.id
    
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.mongodb.private_ip
  }

  provisioner "file" {
  source      = "bootstrap.sh"   # local file path 
  destination = "/tmp/bootstrap.sh" # Destination path on the remote machine
  }


  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}



# for redis db setup

resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet_id
  vpc_security_group_ids = [local.redis_sg_id]
  #iam_instance_profile = aws_iam_instance_profile.bastion.name  # This is not required for database instance because we are not attaching any policy to it. we are not giving access to it to access any other resource. so we are not attaching any IAM role to it. if we want to attach any IAM role to it in future then we can create a new IAM role and attach it to the instance.

  tags = merge (
    

    {
      Name = "${var.project}-${var.environment}-redis"
    },local.common_tags
  )
}

# when instance id is changed as per above snippet below resource will be triggered and it will run the bootstrap-hosts.sh script to update the /etc/hosts file in all the instances with the new private IP address of the database instance. this is required because we are using private IP address to connect to the database instance from other instances. so whenever the private IP address of the database instance is changed then we need to update the /etc/hosts file in all the instances with the new private IP address of the database instance. this is required because we are using private IP address to connect to the database instance from other instances. so whenever the private IP address of the database instance is changed then we need to update the /etc/hosts file in all the instances with the new private IP address of the database instance.
resource "terraform_data" "bootstrap_redis" {
  triggers_replace = [
    aws_instance.redis.id
    
  ]

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = aws_instance.redis.private_ip
  }

  provisioner "file" {
  source      = "bootstrap.sh"   # local file path 
  destination = "/tmp/bootstrap.sh" # Destination path on the remote machine
  }


  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis"
    ]
  }
}