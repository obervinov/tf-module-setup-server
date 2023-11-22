data "digitalocean_ssh_key" "key" {
  name = var.droplet_username
}

data "digitalocean_ssh_key" "terraform_key" {
  name = "terraform"
}

data "digitalocean_project" "project" {
  name = var.droplet_project_name
}

data "digitalocean_domain" "domain" {
  name = var.domain_zone
}

data "digitalocean_droplet_snapshot" "default" {
  count = regex("^packer", var.droplet_image) ? 1 : 0

  name        = var.droplet_image
  region      = "ams3"
  most_recent = true
}