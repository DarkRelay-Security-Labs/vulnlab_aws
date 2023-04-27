# Vulnerable lab on AWS
Terraform script to deploy vulnerable targets on AWS. The script deploys the below containers in the AWS.

`Juice-shop: https://hub.docker.com/r/bkimminich/juice-shop`
`DVWA: https://hub.docker.com/r/vulnerables/web-dvwa`
`XVWA: https://hub.docker.com/r/bitnetsecdave/xvwa`
`Pentest in Docker: https://github.com/Swordfish-Security/Pentest-In-Docker`
 
# Pre-requisites
Terraform installed and in the current $PATH

# Execution
Copy the scripts to the home folder on your Linux distro and run the below commands to deploy or destroy the AWS services created.

## Initialize
`terraform init`

## Deploy DVWA
`terraform apply --auto-approve`

## Destroy DVWA
`terraform destroy --auto-approve`

# About the Terraform Script
Configures ingress rules for ports 22,80,81,82 and 83 to allow SSH and HTTP.

Configures egress rule for all traffic outbound connections.
