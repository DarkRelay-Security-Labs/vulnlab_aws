provider "aws" {
  access_key = "ADD YOUR KEY HERE"
  secret_key = "ADD YOUR KEY HERE"
  region     = "us-east-1"
}

data "template_file" "install_script" {
  template = "${file("vulnlab.sh")}"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_key_pair" "vulnlab" {
  key_name   = "vulnlab"
  public_key = file("~/.ssh/vulnlab.pub")
}

resource "aws_vpc" "vuln_vpc" {
  cidr_block = "10.0.0.0/16"  # Replace with your desired VPC CIDR block

  tags = {
    Name = "vuln-vpc"
  }
}

resource "aws_subnet" "vuln_subnet" {
  vpc_id            = aws_vpc.vuln_vpc.id
  cidr_block        = "10.0.0.0/24"  # Replace with your desired subnet CIDR block
  availability_zone = "us-east-1a"   # Replace with your desired availability zone

  tags = {
    Name = "vuln-subnet"
  }
}

resource "aws_security_group" "vulnlab_sg" {
  name_prefix = "vulnlab_sg"
  description = "Security group for the vulnlab instance"
  
  vpc_id = aws_vpc.vuln_vpc.id  # Associate the security group with the VPC


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

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
    from_port   = 111
    to_port     = 111
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 137
    to_port     = 137
    protocol    = "udp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 138
    to_port     = 138
    protocol    = "udp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 139
    to_port     = 139
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    from_port   = 161
    to_port     = 161
    protocol    = "udp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    from_port   = 199
    to_port     = 199
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 636
    to_port     = 636
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 4444
    to_port     = 4444
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 4567
    to_port     = 4567
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 4568
    to_port     = 4568
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    from_port   = 6200
    to_port     = 6200
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 6306
    to_port     = 6306
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }
  
  ingress {
    from_port   = 9306
    to_port     = 9306
    protocol    = "tcp"
     cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    from_port   = -1  # ICMP type -1 represents all ICMP traffic
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
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
  instance_type = "t2.medium"             # Specify the instance type.
  key_name      = "vulnlab"        # Specify the name of the key pair you want to use to connect to the instance.

  vpc_security_group_ids = [aws_security_group.vulnlab_sg.id]
  subnet_id              = aws_subnet.vuln_subnet.id  # Specify the subnet ID
  associate_public_ip_address = true  # Assign a public IP address to the instance
  
  # Configure the user data to install vulnlab on the instance
  user_data = "${data.template_file.install_script.rendered}"

  tags = {
    Name = "vulndocker"
  }
}

resource "aws_internet_gateway" "vuln_igw" {
  vpc_id = aws_vpc.vuln_vpc.id

  tags = {
    Name = "vuln-igw"
  }
}

resource "aws_route_table" "vuln_route_table" {
  vpc_id = aws_vpc.vuln_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vuln_igw.id
  }

  tags = {
    Name = "vuln-route-table"
  }
}

resource "aws_route_table_association" "vuln_route_association" {
  subnet_id      = aws_subnet.vuln_subnet.id
  route_table_id = aws_route_table.vuln_route_table.id
}
