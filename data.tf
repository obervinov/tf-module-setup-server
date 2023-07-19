data "digitalocean_ssh_key" "ssh_key" {
  name = var.public_key_name
}

data "digitalocean_project" "project" {
  name = var.droplet_project_name
}

data "digitalocean_domain" "domain" {
  count = var.droplet_reserved_ip ? 1 : 0
  name  = var.domain_zone
}