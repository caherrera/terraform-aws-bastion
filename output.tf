output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = module.bastion.private_ip
}

output "public_ip" {
  value = module.bastion.public_ip
}

output "private_dns" {
  value = module.bastion.private_dns
}

output "public_dns" {
  value = module.bastion.public_dns
}

output "aws_security_group" {
  value = aws_security_group.ssh.id
}