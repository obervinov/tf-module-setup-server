data "digitalocean_ssh_key" "ssh_key" {
  name = var.public_key_name
}

data "digitalocean_project" "project" {
  name = var.droplet_project_name
}
