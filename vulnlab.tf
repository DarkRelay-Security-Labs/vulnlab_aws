provider "aws" {
  access_key = "IAMAKEY"
  secret_key = "IAMASECRETKEY"
  region     = "us-east-1"
}

data "template_file" "install_script" {
  template = "${file("vulnlab.sh")}"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "vulnlab_sg" {
  name_prefix = "vulnlab_sg"
  description = "Security group for the vulnlab instance"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 82
    to_port     = 82
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 83
    to_port     = 83
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
    ingress {
    from_port   = 84
    to_port     = 84
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
    
    ingress {
    from_port   = 85
    to_port     = 85
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
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
    Name = "vulnlab_sg"
  }
}
  
  resource "aws_instance" "vulndocker" {
  ami           = "ami-007855ac798b5175e" # Specify the AMI ID for your desired Ubuntu version.
  instance_type = "t2.micro"             # Specify the instance type.
  key_name      = "dvwa_key"        # Specify the name of the key pair you want to use to connect to the instance.

  vpc_security_group_ids = [aws_security_group.vulnlab_sg.id]
  
  
  # Configure the user data to install vulnlab on the instance
  user_data = "${data.template_file.install_script.rendered}"

  tags = {
    Name = "vulndocker"
  }
}
