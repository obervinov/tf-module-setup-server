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

output "droplet_dns_record_external" {
  description = "Public dns record for new droplet"
  value       = var.droplet_dns_record ? digitalocean_record.record_external[0].fqdn : ""
}

output "droplet_dns_record_internal" {
  description = "Private dns record for new droplet"
  value       = var.droplet_dns_record ? digitalocean_record.record_internal[0].fqdn : ""
}

output "droplet_reserved_ip" {
  description = "Reserved ip for new droplet"
  value       = var.droplet_reserved_ip ? digitalocean_reserved_ip.ip[0].ip_address : ""
}
