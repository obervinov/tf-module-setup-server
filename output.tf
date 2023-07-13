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
