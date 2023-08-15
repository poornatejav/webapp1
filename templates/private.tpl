#!/bin/bash
sudo apt-get update -y
sudo apt install apache2 -y
sudo chown -R $USER:$USER /var/www/html
sudo apt install awscli -y
sudo aws s3 scp s3://09051997-0355-1a/index.html /var/www/html/
sudo systemctl start apache2
sudo systemctl enable apache2

PRIVATE_IP="$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)"
sudo scp -i /Users/poornateja/.ssh/web-app-key /Users/poornateja/.ssh/web-app-key.pub  $USER@$PRIVATE_IP:/home/$USER/
