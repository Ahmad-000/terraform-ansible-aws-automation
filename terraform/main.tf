resource "aws_key_pair" "mern_key" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)

  tags = {
    Project = "DevOps-Portfolio"
  }
}


data "aws_ami" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "image-id"
    values = ["ami-0c10fcd4e7ea77b7a"]
  }
}

resource "aws_security_group" "mern_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow SSH from admin IP and HTTP web traffic"

  ingress {
    description = "SSH from admin IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip]
  }

  ingress {
    description = "HTTP web traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = "DevOps-Portfolio"
  }
}

resource "aws_instance" "mern_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.mern_sg.id]
  key_name               = aws_key_pair.mern_key.key_name

  tags = {
    Name    = var.project_name
    Project = "DevOps-Portfolio"
  }
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.mern_server.id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.mern_server.public_ip
}