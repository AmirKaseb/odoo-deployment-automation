provider "aws" {
  region = "eu-west-3" 
}

resource "aws_key_pair" "odoo_key_pair" {
  key_name   = "odoo-key"
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key
}


# Security Group for Odoo
resource "aws_security_group" "odoo_security_group" {
  name        = "odoo-security-group-v2" 
  description = "Security group for Odoo deployment allowing SSH and Odoo traffic"

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
    from_port   = 8069  
    to_port     = 8069
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
    Name        = "odoo-security-group-v2"
    Environment = "production"
    Project     = "odoo-deployment"
  }
}

# EC2 Instance for Odoo
resource "aws_instance" "odoo_instance" {
  ami           = "ami-04a4acda26ca36de0" # Ubuntu 22.04 Image  
  instance_type = "t2.micro"  
  key_name      = aws_key_pair.odoo_key_pair.key_name 
  vpc_security_group_ids = [aws_security_group.odoo_security_group.id]

  tags = {
    Name        = "odoo-instance"
    Environment = "production"
    Project     = "odoo-deployment"
  }

}
output "odoo_instance_public_ip" {
  description = "The public IP address of the Odoo EC2 instance"
  value       = aws_instance.odoo_instance.public_ip
}