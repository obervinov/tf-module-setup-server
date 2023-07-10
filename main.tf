resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "digitalocean_droplet" "droplet" {
  name       = "${var.droplet_name}-${var.droplet_size}-${var.droplet_region}"
  image      = var.droplet_image
  region     = var.droplet_region
  size       = var.droplet_size
  monitoring = true
  ssh_keys   = [data.digitalocean_ssh_key.ssh_key.public_key]
  tags       = var.droplet_tags
  user_data  = <<EOF
#cloud-config
# Add groups to the system
# The following example adds the 'admingroup' group with members 'root' and 'sys'
# and the empty group cloud-users.
groups:
  - admingroup: [root,sys]
  - cloud-users
users:
  - default
  - name: ${var.username}
    gecos: ${var.username}
    primary_group: ${var.username}
    groups: users, admin, docker
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    selinux_user: staff_u
    lock_passwd: false
    passwd: ${random_password.password.result}
    ssh_authorized_keys:
      - ${data.digitalocean_ssh_key.ssh_key.public_key}
ssh_pwauth: false
disable_root: true
runcmd:
- sudo apt -y install apt-transport-https ca-certificates curl software-properties-common net-tools
- curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
- sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
- sudo apt -y update && sudo apt-get -y upgrade
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
