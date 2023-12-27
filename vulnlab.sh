#!/bin/bash
sudo apt update
sudo apt-get install docker -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo apt-get install netcat
sudo apt install net-tools

#Configure Juice-shop https://github.com/juice-shop/juice-shop
sudo docker pull bkimminich/juice-shop
sudo docker run -d --restart always -p 80:3000 bkimminich/juice-shop

# Create a user-defined network
sudo docker network create local-network

# Configure DVWA https://github.com/digininja/DVWA
sudo docker pull vulnerables/web-dvwa
sudo docker run --name dvwa -d -p 81:80 --restart always --network local-network vulnerables/web-dvwa

# Configure XVWA https://github.com/s4n7h0/xvwa accessible only to dvwa
sudo docker pull bitnetsecdave/xvwa
sudo docker run --name xvwalocal -d -p 127.0.0.1:8082:80 --restart always --network local-network --add-host dvwa:127.0.0.1 bitnetsecdave/xvwa

# Configure XVWA https://github.com/s4n7h0/xvwa
sudo docker pull bitnetsecdave/xvwa
sudo docker run --name xvwa -d -p 82:80 --restart always bitnetsecdave/xvwa

#Configure Vulnerable Graphql https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application
sudo docker pull frost19k/dvga
sudo docker run --name dvga -d --restart always -p 84:5013 frost19k/dvga

#Configure Vampi https://hub.docker.com/r/erev0s/vampi
sudo docker pull erev0s/vampi
sudo docker run --name vampi -d --restart always -p 85:5000 erev0s/vampi
