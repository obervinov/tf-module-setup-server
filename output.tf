output "droplet_id" {
  description = "Droplet id"
  value       = digitalocean_droplet.default.id
}

output "droplet_name" {
  description = "Droplet name"
  value       = digitalocean_droplet.default.name
}

output "droplet_external_ip" {
  description = "Droplet external ip-address"
  value       = digitalocean_droplet.default.ipv4_address
}

output "droplet_username" {
  description = "Username for new user"
  value       = var.droplet_username
}

output "droplet_ssh_key_fingerprint" {
  description = "SSH Key fingerprint"
  value       = data.digitalocean_ssh_key.default.fingerprint
}

output "droplet_dns_record" {
  description = "Public dns record for new droplet"
  value       = var.droplet_dns ? digitalocean_record.default[0].fqdn : ""
}

output "droplet_reserved_ip" {
  description = "Reserved ip for new droplet"
  value       = var.droplet_reserved_ip ? digitalocean_reserved_ip.default[0].ip_address : ""
}

output "droplet_private_ip" {
  description = "Private ip for new droplet"
  value       = digitalocean_droplet.default.ipv4_address_private
}

output "persistent_data_path" {
  description = "The path to the directory for storing persistent information and configurations"
  value       = var.app_data
}

output "additional_volume" {
  description = "Additional volume for new droplet"
  value       = var.droplet_volume_size > 0 ? digitalocean_volume.default[0].name : ""
}

output "app_cname_records" {
  value = join(", ", [for item in var.app_cname_records : "${item}.${data.digitalocean_domain.default.name}"])
}
