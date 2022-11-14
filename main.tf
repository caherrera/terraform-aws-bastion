data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Ubuntu
}

data "aws_subnet" "subnet" {
  id = var.subnet_id
}


resource "aws_security_group" "ssh" {
  description = "controls SSH access"

  vpc_id = data.aws_subnet.subnet.vpc_id
  name   = "${var.name} SSH Security Group"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

data "aws_key_pair" "key" {
  key_name = var.key_pair_name
}

module "bastion" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 3.0"
  name                        = lower(var.name)
  ami                         = coalesce(var.ami, data.aws_ami.ubuntu.id)
  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.key.key_name
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.ssh.id]
  subnet_id                   = var.subnet_id
  tags                        = var.tags
  associate_public_ip_address = var.associate_public_ip_address

}


