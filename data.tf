locals {

  default_packages = [
    "apt-transport-https",
    "ca-certificates",
    "curl",
    "software-properties-common",
    "net-tools",
    "gpg"
  ]

  network = {
    ethernets = {
      eth1 = {
        addresses     = [data.digitalocean_vpc.vpc.ip_range]
        mtu           = 1500
        nameservers   = sort(var.nameserver_ips)
        searchdomains = ["consul"]
        domain        = "consul"
      }
    }
  }

  users = [
    {
      name                = var.droplet_username
      groups              = ["sudo"]
      sudo                = ["ALL=(ALL) NOPASSWD:ALL"]
      ssh_authorized_keys = [data.digitalocean_ssh_key.key.public_key]
    },
    {
      name                = "terraform"
      groups              = ["sudo"]
      sudo                = ["ALL=(ALL) NOPASSWD:ALL"]
      ssh_authorized_keys = [data.digitalocean_ssh_key.terraform_key.public_key]
    }
  ]

  runcmd = [
    # Install docker for all environment
    "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
    "echo \"deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \"$$(. /etc/os-release && echo \"$VERSION_CODENAME\")\" stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
    "DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical sudo apt-get -y update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
    "sudo usermod -aG docker ${var.droplet_username}",
    # Directory for configuration files provisioner
    "sudo mkdir -p ${var.persistent_data_path}/configs && sudo chown ${var.droplet_username}.terraform ${var.persistent_data_path}/configs && sudo chmod 775 ${var.persistent_data_path}/configs"
  ]

  user_data = <<EOF
#cloud-config
users:
${join("\n", flatten([for u in local.users : [
    "- name: ${u.name}",
    "  groups:",
    "    - ${join("\n    - ", u.groups)}",
    "  sudo:",
    "    - ${join("\n    - ", u.sudo)}",
    "  ssh-authorized-keys:",
    "    - ${u.ssh_authorized_keys[0]}"
  ]]))}

ssh_pwauth: false
disable_root: true
package_update: true
package_upgrade: true
manage_etc_hosts: true

network:
${indent(2, yamlencode(local.network))}

packages:
${join("\n", formatlist("  - '%s'", local.default_packages))}
${var.packages_list != null ? join("\n", formatlist("  - '%s'", var.packages_list)) : ""}

runcmd:
${indent(2, join("\n", local.runcmd))}
EOF
}

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

data "digitalocean_vpc" "vpc" {
  name   = "${var.vpc}-${var.droplet_region}"
}
