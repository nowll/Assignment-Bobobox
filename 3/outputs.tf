output "public_ip" {
  description = "The public IP address of the provisioned AWS VM"
  value       = aws_instance.web_server.public_ip
}
