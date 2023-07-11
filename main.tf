resource "random_password" "password" {
  length = 16
  special = false
}

resource "null_resource" "password_hash" {
  provisioner "local-exec" {
    # docker, because mkpasswd is missing on macos
    command = "docker run -it --rm alpine mkpasswd ${random_password.password.result}"
    interpreter = ["sh", "-c"]
    environment = {
      LC_ALL = "C.UTF-8"
    }
  }
}

variable "password_hash" {
  description = "Hash of the password to create a new user"
  type = string
  default = null_resource.password_hash.*.stdout[0]
}

resource "digitalocean_droplet" "droplet" {
  name       = "${var.droplet_name}-${var.droplet_size}-${var.droplet_region}"
  image      = var.droplet_image
  region     = var.droplet_region
  size       = var.droplet_size
  monitoring = true
  ssh_keys   = [data.digitalocean_ssh_key.ssh_key.id]
  tags       = var.droplet_tags
  user_data  = <<EOF
#cloud-config
users:
  - name: ${var.username}
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    passwd: ${var.password_hash}
    ssh_authorized_keys:
      - ${data.digitalocean_ssh_key.ssh_key.public_key}
#ssh_pwauth: false
#disable_root: true
package_update: true
package_upgrade: true
packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - software-properties-common
  - net-tools
runcmd:
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  - sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  - DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -y update
  - DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical apt-get -y upgrade
EOF
  connection {
    host = self.ipv4_address
    user = "${var.username}"
    password = "${random_password.password.result}"
    type = "ssh"
    private_key = data.digitalocean_ssh_key.ssh_key.public_key
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = var.remote_commands
  }
}

resource "digitalocean_project_resources" "project_resources" {
  project = data.digitalocean_project.project.id
  resources = [
    digitalocean_droplet.droplet.urn
  ]
}
