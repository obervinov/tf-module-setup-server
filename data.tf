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
