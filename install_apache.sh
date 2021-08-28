#!/bin/sh
sudo apt-get update -y
sudo apt install -y apache2
sudo systemctl status apache2
sudo systemctl start apache2
echo "Hello from the EC2 instance." > /var/www/html/index.html
