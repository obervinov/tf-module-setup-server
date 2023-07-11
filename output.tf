output "droplet" {
  description = "Droplet name"
  value       = digitalocean_droplet.droplet.name
}

output "username" {
  description = "Username for new user"
  value       = var.username
}

output "password" {
  description = "Password hash for new user"
  value       = file("${path.module}/.password")
}
output "sshkey" {
  description = "SSH Key fingerprint"
  value       = data.digitalocean_ssh_key.ssh_key.fingerprint
}
