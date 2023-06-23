terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}



variable "awsprops" {
    default = {
    region = "us-west-2"
    vpc = "vpc-0413b5f2ca2603a9a"
    ami = "ami-00aa0673b34e3c150"
    itype = "t2.micro"
    subnet = "subnet-08633bf83df067f1c"
    publicip = true
    keyname = "ansible_keypair"
    secgroupname = "sg-0730765e6f68ac742"
  }
}

provider "aws" {
  region = lookup(var.awsprops, "region")
}




resource "aws_instance" "project-iac" {
  ami = lookup(var.awsprops, "ami")
  instance_type = lookup(var.awsprops, "itype")
  subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
  associate_public_ip_address = lookup(var.awsprops, "publicip")
  key_name = lookup(var.awsprops, "keyname")


  vpc_security_group_ids = [
   lookup(var.awsprops, "secgroupname")
  ]
  
  tags = {
    Name ="SERVER01"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

}


output "ec2instance" {
  value = aws_instance.project-iac.public_ip
}