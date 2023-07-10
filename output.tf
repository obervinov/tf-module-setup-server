output "droplet" {
  description = "Droplet Name"
  value       = digitalocean_droplet.droplet.name
}

output "username" {
  description = "New user username"
  value       = var.username
}

output "sshkey" {
  description = "SSH Key fingerprint"
  value       = data.digitalocean_ssh_key.ssh_key.fingerprint
}
