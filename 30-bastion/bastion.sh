#!/bin/bash


# we are creating 50gb root disk , but only 20gb is partioned 
# Remaining 30gb storage we need to extend using below commands
growpart /dev/nvme0n1 4

lvextend -r -L +30GB /dev/mapper/RootVG-homeVol

xfs_growfs /home



yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform


# creating databases
cd /home/ec2-user
git clone https://github.com/Phanikumar-R/roboshop-infra-dev.git
chown ec2-user:ec2-user -R roboshop-infra-dev
cd roboshop-infra-dev/40-databases
terraform init
terraform apply -auto-approve

# creating components
cd /home/ec2-user
git clone https://github.com/Phanikumar-R/roboshop-infra-dev.git
chown ec2-user:ec2-user -R roboshop-infra-dev
cd roboshop-infra-dev/90-components
terraform init
terraform apply -auto-approve