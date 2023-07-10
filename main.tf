resource "digitalocean_droplet" "droplet" {
  name       = "${var.droplet_name}-${var.droplet_size}-${var.droplet_region}"
  image      = var.droplet_image
  region     = var.droplet_region
  size       = var.droplet_size
  monitoring = true
  ssh_keys   = [data.digitalocean_ssh_key.ssh_key.fingerprint]
  tags       = var.droplet_tags
  user_data  = <<-EOF
    #!/bin/bash
    echo "https://github.com/obervinov"
  EOF
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = data.digitalocean_ssh_key.ssh_key.public_key
    timeout = "2m"
  }
  provisioner "local-exec" {
    command = <<-EOT
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i "${digitalocean_droplet.droplet.ipv4_address}," ${var.ansible_playbook} \
      -e '{"public_key":"${data.digitalocean_ssh_key.ssh_key.public_key}","ansible_host":"${digitalocean_droplet.droplet.ipv4_address}","username":"${var.username}","password":"${var.password}","packages_list":[${join(",", var.packages_list)}]}'
    EOT
    working_dir = path.module
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
