provider "aws" {
  access_key = "IAMACCESSKEY"
  secret_key = "IAMSECRETKEY"
  region     = "us-east-1"
}

data "dvwa_file" "dvwa_script" {
  template = "${file("dvwa.sh")}"
}

resource "aws_security_group" "dvwa_sg" {
  name_prefix = "dvwa_sg"
  description = "Security group for DVWA instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dvwa_sg"
  }
}

resource "aws_instance" "dvwa" {
  ami           = "ami-007855ac798b5175e" # Specify the AMI ID for your desired Ubuntu version.
  instance_type = "t2.micro"             # Specify the instance type.
  key_name      = "dvwa_key"        # Specify the name of the key pair you want to use to connect to the instance.

  vpc_security_group_ids = [aws_security_group.dvwa_sg.id]
  
  
  # Configure the user data to install DVWA on the instance
  user_data = "${data.dvwa_file.dvwa_script.rendered}"

  tags = {
    Name = "DVWA Instance"
  }

}
