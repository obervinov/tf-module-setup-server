output "droplet" {
  description = "Droplet name"
  value       = digitalocean_droplet.droplet.name
}

output "external-ip" {
  description = "Droplet external ip-address"
  value       = digitalocean_droplet.droplet.ipv4_address
}

output "username" {
  description = "Username for new user"
  value       = var.username
}

output "sshkey" {
  description = "SSH Key fingerprint"
  value       = data.digitalocean_ssh_key.ssh_key.fingerprint
}

output "dns_record" {
  count       = var.droplet_dns_record ? 1 : 0
  description = "Dns record for new droplet"
  value       = digitalocean_domain.domain.name
}

output "reserved_ip" {
  count       = var.reserved_ip ? 1 : 0
  description = "Reserved ip for new droplet"
  value       = digitalocean_reserved_ip.reserved_ip.ip_address
}
