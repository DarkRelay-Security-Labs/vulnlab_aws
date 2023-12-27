# Private Pentest Lab on AWS
Terraform script to deploy below vulnerable container targets on AWS.

`Juice-shop:` https://hub.docker.com/r/bkimminich/juice-shop

`DVWA:` https://hub.docker.com/r/vulnerables/web-dvwa

`XVWA:` https://hub.docker.com/r/bitnetsecdave/xvwa

`Vulnerable Graphql:` https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application

`Vulnerable API:` https://github.com/erev0s/VAmPI
 
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
`Web`: http://<EC2_Public_IP>

## Destroy Vulnlab
`terraform destroy --auto-approve`

# About the Terraform Script
Configures one EC2 t2.medium instance to host containers.

Configures one security group.

Configures ingress rules for ports 22,80,81,82,84, and 85 to allow traffic from your IP only.

Compromise DVWA to access Port 8082 and reach XVWA (this is for pivoting scenarios).

Configures ingress rules for port 22 to allow traffic from any IP.

Configures egress rule for all traffic outbound connections.

Happy hunting!!
