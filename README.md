# Vulnerable lab on AWS
Terraform script to deploy below vulnerable container targets on AWS.

`Juice-shop:` https://hub.docker.com/r/bkimminich/juice-shop

`DVWA:` https://hub.docker.com/r/vulnerables/web-dvwa

`XVWA:` https://hub.docker.com/r/bitnetsecdave/xvwa

`Pentest in Docker:` https://github.com/Swordfish-Security/Pentest-In-Docker

`Vulnerable Graphql:` https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application

`Vulnerable API:` https://github.com/erev0s/VAmPI

`Vulnerable SMB:` https://github.com/dperson/samba

`Vulnerable FTP:` vsftpd-2.3.4-vulnerable

`Vulnerable SMTP:` https://github.com/vulhub/vulhub/tree/master/opensmtpd/CVE-2020-7247
 
# Pre-requisites

## Terraform installed and in the current $PATH

`Create your AWS keys:` https://www.youtube.com/watch?v=HuE-QhrmE1c

## Update the vulnlab.tf file with your AWS keys. 

`access_key = "ADD YOUR KEY HERE"`

`secret_key = "ADD YOUR KEY HERE"`

## Create key pairs with name vulnlab. 

### Run the below command in your Kali linux terminal.

`ssh-keygen -q -t rsa -N '' -f ~/.ssh/vulnlab <<<y >/dev/null 2>&1`

# Execution

## Download
`git clone https://github.com/DarkRelayLabs/vulnlab_aws.git && cd vulnlab_aws`

## Initialize
`terraform init`

## Deploy Vulnlab
`terraform apply --auto-approve`

## Start Pentesting
On your browser navigate to http://<EC2_Public_IP> to start the tests.

## Destroy Vulnlab
`terraform destroy --auto-approve`

# About the Terraform Script
Configures one EC2 micro instance to host containers.

Configures one security group.

Configures ingress rules for ports 21,25,80,81,83,84,85,139,445 and 6200 to allow traffic from your IP only.

Compromise DVWA to access Port 8082 and reach XVWA (this is for pivoting scenarios).

Configures ingress rules for port 22 to allow traffic from any IP.

Configures egress rule for all traffic outbound connections.

Happy hunting!!
