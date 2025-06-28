provider "aws" {
  region     = "us-east-2"
  access_key = "" # Add your AWS access key
  secret_key = "" # Add your AWS secret key
}

# VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "PRT-VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "PRT_IGW"
  }
}

# Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    Name = "PRT-Subnet"
  }
}

# Route Table
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "PRT-RT"
  }
}

# Route Table Association
resource "aws_route_table_association" "myrta" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.myrt.id
}

# Security Group
resource "aws_security_group" "mysg" {
  name        = "my-sg"
  description = "Allow SSH, HTTP, and 8080"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "PRT-SG"
  }
}

# Define reusable instance resource
resource "aws_instance" "inst1" {
  ami                         = "" # Insert latest Amazon Linux 2 AMI
  instance_type               = "t2.medium"
  key_name                    = "richa"
  subnet_id                   = aws_subnet.my_subnet.id
  vpc_security_group_ids      = [aws_security_group.mysg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Ansible"
  }
}

resource "aws_instance" "inst2" {
  ami                         = "" # Insert latest Amazon Linux 2 AMI
  instance_type               = "t2.medium"
  key_name                    = "richa"
  subnet_id                   = aws_subnet.my_subnet.id
  vpc_security_group_ids      = [aws_security_group.mysg.id]
  associate_public_ip_address = true

  tags = {
    Name = "J-M"
  }
}

resource "aws_instance" "inst3" {
  ami                         = "" # Insert latest Amazon Linux 2 AMI
  instance_type               = "t2.medium"
  key_name                    = "richa"
  subnet_id                   = aws_subnet.my_subnet.id
  vpc_security_group_ids      = [aws_security_group.mysg.id]
  associate_public_ip_address = true

  tags = {
    Name = "J-S"
  }
}

# Allocate Elastic IPs
resource "aws_eip" "eip1" {
  instance = aws_instance.inst1.id
  vpc      = true
}

resource "aws_eip" "eip2" {
  instance = aws_instance.inst2.id
  vpc      = true
}

resource "aws_eip" "eip3" {
  instance = aws_instance.inst3.id
  vpc      = true
}
