#!/bin/bash
sudo apt update
sudo apt-get install docker -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker

#Configure Juice-shop https://github.com/juice-shop/juice-shop
sudo docker pull bkimminich/juice-shop
sudo docker run -d -p 80:3000 bkimminich/juice-shop

# Create a user-defined network
sudo docker network create local-network

# Configure DVWA https://github.com/digininja/DVWA
sudo docker pull vulnerables/web-dvwa
sudo docker run --name web-dvwa -d -p 81:80 --restart always --network local-network vulnerables/web-dvwa

# Configure XVWA https://github.com/s4n7h0/xvwa 
sudo docker pull bitnetsecdave/xvwa
sudo docker run --name xvwa -d -p 127.0.0.1:82:80 --restart always --network local-network --add-host xvwa:127.0.0.1 bitnetsecdave/xvwa

#Configure Vulnerable Container https://github.com/Swordfish-Security/Pentest-In-Docker
sudo docker pull dvyakimov/vuln-wheezy
sudo docker run --name vulnwheezy -d -v /var/run/docker.sock:/var/run/docker.sock --rm -it -p 83:80 dvyakimov/vuln-wheezy

#Configure Vulnerable Graphql https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application
sudo docker pull frost19k/dvga
sudo docker run --name dvga -d --rm -p 84:5013 frost19k/dvga

#Configure Vampi https://hub.docker.com/r/erev0s/vampi
sudo docker pull erev0s/vampi
sudo docker run --name vampi -d --rm -p 85:5000 erev0s/vampi

##*******----------Backup-------------------
#Configure DVWA https://github.com/digininja/DVWA
#sudo docker pull vulnerables/web-dvwa
#sudo docker run --name web-dvwa -d -p 81:80 --restart always vulnerables/web-dvwa

#Configure XVWA https://github.com/s4n7h0/xvwa 
#sudo docker pull bitnetsecdave/xvwa
#sudo docker run --name xvwa -d -p 82:80 --restart always bitnetsecdave/xvwa
