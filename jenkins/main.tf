terraform {
  backend "s3" {
    bucket = "jedbk"
    key    = "misc/prometheus/terraform.tfstate"
    region = "us-east-1"

  }
}

data "aws_ami" "centos8" {
  most_recent = true
  name_regex  = "Centos-8-DevOps-Practice"
  owners      = ["973714476881"]
}


resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.centos8.image_id
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0012107af37e36eec"]

  tags = {
    Name = "jenkins-server"
  }
}

resource "aws_route53_record" "jenkins" {
  zone_id = "Z05050322P8QFCN8M8LU9"
  name    = "jenkins"
  type    = "A"
  ttl     = 30
  records = [aws_instance.jenkins.private_ip]
}

resource "aws_route53_record" "jenkins-public" {
  zone_id = "Z05050322P8QFCN8M8LU9"
  name    = "jenkins-public"
  type    = "A"
  ttl     = 30
  records = [aws_instance.jenkins.public_ip]
}