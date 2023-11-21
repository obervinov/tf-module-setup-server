output "droplet_name" {
  description = "Droplet name"
  value       = digitalocean_droplet.droplet.name
}

output "droplet_external_ip" {
  description = "Droplet external ip-address"
  value       = digitalocean_droplet.droplet.ipv4_address
}

output "droplet_username" {
  description = "Username for new user"
  value       = var.username
}

output "droplet_ssh_key_fingerprint" {
  description = "SSH Key fingerprint"
  value       = data.digitalocean_ssh_key.key.fingerprint
}

output "droplet_dns_record" {
  description = "Public dns record for new droplet"
  value       = var.droplet_dns_record ? digitalocean_record.record[0].fqdn : ""
}

output "droplet_reserved_ip" {
  description = "Reserved ip for new droplet"
  value       = var.droplet_reserved_ip ? digitalocean_reserved_ip.ip[0].ip_address : ""
}

output "droplet_private_ip" {
  description = "Private ip for new droplet"
  value       = digitalocean_droplet.droplet.ipv4_address_private
}

output "persistent_data_path" {
  description = "The path to the directory for storing persistent information and configurations"
  value       = var.persistent_data_path
}

output "droplet_additional_volume" {
  description = "Additional volume for new droplet"
  value       = var.additional_volume_size > 0 ? digitalocean_volume.volume[0].id : ""
}

output "additional_volume" {
  description = "Additional volume for new droplet"
  value       = var.additional_volume_size > 0 ? digitalocean_volume.volume[0].name : ""
}