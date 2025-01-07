provider "aws" {
  region = "eu-west-3"
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow custom TCP on port 8080 and SSH"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_custom_tcp" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.jenkins_sg.id
  cidr_ipv4         = "0.0.0.0/0"

  ip_protocol = "-1"
}

resource "aws_instance" "jenkins_server" {
  ami             = "ami-07dc1ccdcec3b4eab"
  instance_type   = "t2.medium"
  key_name        = "jenkins"
  security_groups = [aws_security_group.jenkins_sg.name]

  tags = {
    Name = "jenkins-server"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo groupadd docker
    sudo usermod -aG docker ec2-user
    su -s ec2-user
    docker run -d --name jenkins -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins/jenkins:lts
    sudo chmod 666 /var/run/docker.sock
    docker exec -u 0 jenkins /bin/sh -c "apt-get update && apt install docker.io -y && docker --version"
    EOF
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_server.id
}

output "jenkins_server_public_ip" {
  value = aws_eip.jenkins_eip.public_ip
}
