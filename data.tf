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
        mtu           = 1500
        nameservers   = sort(var.os_nameservers)
        searchdomains = ["consul"]
        domain        = "consul"
      }
    }
  }

  default_commands = [
    "sudo mkdir -p ${var.app_data}/${var.app_configurations}",
    "sudo chown ${var.droplet_username}:terraform ${var.app_data}/${var.app_configurations}",
    "sudo chmod 775 ${var.app_data}/${var.app_configurations}",
    "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
    "echo \"deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \"$(. /etc/os-release && echo \"$VERSION_CODENAME\")\" stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
    "DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical sudo apt-get -y update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
    "sudo usermod -aG docker ${var.droplet_username}"
  ]

  user_data = <<EOF
#cloud-config

ssh_pwauth: false
disable_root: true
package_update: true
package_upgrade: true
manage_etc_hosts: true

users:
  - name: ${var.droplet_username}
    groups:
      - sudo
    sudo:
      - ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ${data.digitalocean_ssh_key.default.public_key}
  - name: terraform
    groups:
      - sudo
    sudo:
      - ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ${data.digitalocean_ssh_key.ci_cd.public_key}

write_files:
  - path: /etc/systemd/resolved.conf.d/terraform-module-setup-environment.conf
    content: |
      [Resolve]
      DNS=${join(" ", formatlist("%s", var.os_nameservers))}
      DNSSEC=false
      Domains=~consul

packages:
${local.default_packages != null ? join("\n", formatlist("  - '%s'", local.default_packages)) : ""}
${var.os_packages != null ? join("\n", formatlist("  - '%s'", var.os_packages)) : ""}

runcmd:
  - systemctl restart systemd-resolved
${local.default_commands != null ? join("\n", formatlist("  - '%s'", local.default_commands)) : ""}
EOF
}

data "digitalocean_ssh_key" "default" {
  name = var.droplet_username
}

data "digitalocean_ssh_key" "ci_cd" {
  name = "terraform"
}

data "digitalocean_project" "default" {
  name = var.droplet_project
}

data "digitalocean_domain" "default" {
  name = var.droplet_dns_zone
}

data "digitalocean_vpc" "default" {
  name = var.droplet_vpc
}

data "consul_acl_token_secret_id" "default" {
  count = var.os_consul_agent ? 1 : 0

  accessor_id = consul_acl_token.node[0].accessor_id
}
