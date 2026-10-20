variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "eu-north-1"
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "project_name" {
  description = "Name prefix for project resources"
  type        = string
  default     = "mern-terraform-ansible"
}

variable "admin_ip" {
  description = "Public IPv4 address allowed to connect through SSH"
  type        = string
  default     = "154.81.237.120/32"
}

variable "public_key_path" {
  description = "Path to the local SSH public key"
  type        = string
}