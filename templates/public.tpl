#!/bin/bash
sudo apt-get update -y
sudo apt install apache2 -y
sudo chown -R $USER:$USER /var/www/html
sudo systemctl start apache2
sudo systemctl enable apache2

