sudo file -s /dev/xvdh

sudo mkfs.ext4 /dev/xvdh

sudo mkdir -p /var/jenkins_home

sudo chmod -R 777 /var/jenkins_home

#reboot after this
sudo bash -c 'echo "/dev/xvdh   /var/jenkins  ext4      defaults,nofail     0     2" >> /etc/fstab'
