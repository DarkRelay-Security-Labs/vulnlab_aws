#!/bin/bash
sudo apt update
sudo apt-get install docker -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo apt-get install netcat
sudo apt install net-tools
mkdir -p /tmp/test/share
mkdir -p /tmp/test/nfsshare
echo secretpass > /tmp/test/share/password.txt
echo secretpass > /tmp/test/nfsshare/password.txt

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

#Configure https://github.com/dperson/samba
sudo docker pull dperson/samba
sudo docker run --name samba -d --restart always -p 139:139 -p 445:445 -p 137:137/udp -p 138:138/udp dperson/samba -v /tmp/test/share:/share:r -S -p \
            -u "john;password1" \
            -u "bob;password2" \
            -s "public;/share" \
            -s "servershare;/servershare;no;no;no;john,bob" \
            -s "johnshare;/johnshare;yes;no;no;john" \
            -s "bobshare;/bobshare;yes;no;no;bob"

#Configure vulnerable ftp
sudo docker pull uexpl0it/vulnerable-packages:backdoored-vsftpd-2.3.4
sudo docker run --name vsftpd -d --restart always -p 21:21 -p 6200:6200 uexpl0it/vulnerable-packages:backdoored-vsftpd-2.3.4

#Configure vulnerable smtp
sudo docker pull turgon37/smtp-relay
sudo docker run --name smtpd -d --restart always -p 25:25 -e  "RELAY_POSTMASTER=postmaster@darkrelay.io" -e "RELAY_MYHOSTNAME=smtp-relay.darkrelay.io" -e "RELAY_MYDOMAIN=darkrelay.io" -e "RELAY_HOST=[127.0.0.1]:25" turgon37/smtp-relay

#Configure snmp
sudo docker pull ehazlett/snmpd:latest
sudo docker run --name snmpd -d --restart always -p 161:161/udp -p 199:199 ehazlett/snmpd:latest

#Configure nfs
sudo docker pull itsthenetwork/nfs-server-alpine
sudo docker run --name nfs -d --restart always --privileged -v /tmp/test/nfsshare:/nfsshare -e SHARED_DIRECTORY=/nfsshare -p 2049:2049 itsthenetwork/nfs-server-alpine:latest

#Heartbleed
sudo docker pull vulhub/openssl:1.0.1c-with-nginx
sudo docker run -d --restart always --name heartbleed -p 443:443 -p 8080:80 -v /var/www/html:/var/www/html vulhub/openssl:1.0.1c-with-nginx
