#!/bin/bash

growpart /dev/nvme0n1 4


# we are creating 50gb root disk ,but only 20 gb is partitioned and formatted, so we need to extend the logical volume and file system to utilize the remaining 30 gb of space

lvextend -r -L +30G /dev/mapper/RootVG-homeVol # -r is for resizing the file system along with the logical volume, -L is for specifying the size to extend the logical volume by, in this case 30 gb

xfs_growfs /home   # This is required to grow the file system after extending the logical volume i.e 30 gb in this case

yum install -y yum-utils

yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

yum -y install terraform