# Vulnerable lab on AWS
Terraform script to deploy vulnerable targets on AWS. The script deploys the below containers in the AWS.

`Juice-shop:` https://hub.docker.com/r/bkimminich/juice-shop

`DVWA:` https://hub.docker.com/r/vulnerables/web-dvwa

`XVWA:` https://hub.docker.com/r/bitnetsecdave/xvwa

`Pentest in Docker:` https://github.com/Swordfish-Security/Pentest-In-Docker

`Vulnerable Graphql:` https://github.com/dolevf/Damn-Vulnerable-GraphQL-Application

`Vulnerable API:` https://github.com/erev0s/VAmPI
 
# Pre-requisites

## Terraform installed and in the current $PATH

`Create your AWS keys:` https://www.youtube.com/watch?v=HuE-QhrmE1c

## Update the vulnlab.tf file with your AWS keys. 

`access_key = "ADD YOUR KEY HERE"`

`secret_key = "ADD YOUR KEY HERE"`

## Create key pairs with name dvwa_key

`Create EC2 Key Pair:` https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html#having-ec2-create-your-key-pair

# Execution
Copy the scripts to the home folder on your Linux distro and run the below commands to deploy or destroy the AWS services created.

## Initialize
`terraform init`

## Deploy DVWA
`terraform apply --auto-approve`

## Destroy DVWA
`terraform destroy --auto-approve`

# About the Terraform Script
Configures one EC2 micro instance to host containers.

Configures one security group.

Configures ingress rules for ports 80,81,82,83,85 and 85 to allow traffic from your IP only.

Configures ingress rules for port 22 to allow traffic from any IP.

Configures egress rule for all traffic outbound connections.

Happy hunting!!
