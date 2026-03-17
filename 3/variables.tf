variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.micro"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to your local public SSH key"
  default     = "C:/Users/Noel/.ssh/id_rsa.pub"
  type        = string
}
