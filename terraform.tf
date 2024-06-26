
provider "aws" {
  region = "ap-south-1"                                                                                 
}
resource "aws_key_pair" "my_key_pair" {                                                                   # Creating a key pair for SSH access
  public_key = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDvO[...] your_public_key_here
EOF
}
resource "aws_security_group" "allow_ssh" {                                                                # Defining a security group with restricted SSH access
  name = "allow_ssh"
  description = "Security group allowing SSH access from specific IP"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["<your_ip_address>/32"] # Replace with your specific IP
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "my_demo_server" {                                                                           # Creating the EC2 instance
  ami           = "ami-0beeff992b88e8822"                                                                          # example AMI ID
  instance_type = "t2.micro" 
  key_name     = aws_key_pair.my_key_pair.public_key
  security_groups = [aws_security_group.allow_ssh.name]
}
