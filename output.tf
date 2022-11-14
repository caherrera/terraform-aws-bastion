output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = module.bastion.private_ip
}
