/* 
-------------------------------------------------------------
 Automated solution for integrating continuous monitoring systems Prometheus
 "Ready to go; the example configuration is set up to use Terraform
 Comprehensive guide available at: 
 https://octoops.github.io/en/continuing-processes/monitoring/prometheus/integration/prometheus-integration#top  
 docker-compose version: "3.8"
 For full details on what each version includes and how to upgrade, see: 
 Compose and Docker compatibility matrix
 https://docs.docker.com/compose/compose-file/

 Copyleft (c) by Alex Sonar 2021
------------------------------------------------------------- 
*/

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["<owners>"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_secutity_group.prometheus-server-dev.id]
  user_data = file("../prometheus/installers/install_base_tools.sh")

  tags = {
    Name = "prometheus-server-dev"
    Owner = "OwnerName"
  }
}

resource "aws_secutity_group" "prometheus-server-dev" {
     name = "security-group-prometheus-server-dev"
     description = "Security group for prometheus momitoring development ENV"

     ingress {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
     }

     ingress {
          description = "TLS from VPC"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
     }

     ingress {
          description = "SSH"
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
    Name = "allow_tls_tf_sg"
  }
  
}

resource "aws_key_pair" "id_rsa" {
  key_name   = "id_rsa"
  public_key = "$<Var with id_rsa>"
}