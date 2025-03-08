output "vm_aws_ip" {
  description = "The public IP address of the AWS VM"
  value       = aws_instance.vm.public_ip
}

output "vm_azure_ip" {
  description = "The public IP address of the Azure VM"
  value       = azurerm_public_ip.ip.ip_address

}
