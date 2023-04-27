#!/bin/bash
sudo apt update
sudo apt-get install docker -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

#Configure Juice-shop
sudo docker pull bkimminich/juice-shop
sudo docker run -d -p 80:3000 bkimminich/juice-shop

#Configure DVWA
sudo docker pull vulnerables/web-dvwa
sudo docker run --name web-dvwa -d -p 81:80 --restart always vulnerables/web-dvwa

#Configure XVWA
sudo docker pull bitnetsecdave/xvwa
sudo docker run --name xvwa -d -p 82:80 --restart always bitnetsecdave/xvwa

# Configure Vulnerable Container https://github.com/Swordfish-Security/Pentest-In-Docker
sudo docker pull dvyakimov/vuln-wheezy
sudo docker run --name vulnwheezy -d -v /var/run/docker.sock:/var/run/docker.sock --rm -it -p 83:80 dvyakimov/vuln-wheezy
