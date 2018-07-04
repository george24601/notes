sudo file -s /dev/xvdh

sudo mkfs.ext4 /dev/xvdh

sudo mkdir /jenkins

sudo chmod 777 /jenkins

sudo bash -c 'echo "/dev/xvdh   /jenkins  ext4      defaults,nofail     0     2" >> /etc/fstab'
