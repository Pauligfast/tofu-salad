#!/bin/bash
sudo apt update
sudo apt install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
sudo echo "<html><body><h1>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</h1></body></html>" > /var/www/html/index.html