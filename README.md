# DVWA on AWS
Terraform script to deploy damn vulnerable web application(DVWA) on AWS.

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
Configures ingress rules for ports 22 and 80 to allow SSH and HTTP.

Configures egress rule for all traffic outbound connections.
