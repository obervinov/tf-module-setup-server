resource "digitalocean_droplet" "droplet" {
  name       = "${var.droplet_name}-${var.droplet_size}-${var.droplet_region}"
  image      = var.droplet_image
  region     = var.droplet_region
  size       = var.droplet_size
  monitoring = true
  ssh_keys   = [data.digitalocean_ssh_key.key.id]
  tags       = var.droplet_tags
  user_data  = <<EOF
#cloud-config
users:
  - name: ${var.username}
    groups:
      - sudo
    sudo:
      - ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ${data.digitalocean_ssh_key.key.public_key}
ssh_pwauth: false
disable_root: true
package_update: true
package_upgrade: true
packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - software-properties-common
  - net-tools
  - gpg
${join("\n", formatlist("  - %s", var.packages_list))}
runcmd:
  # Install docker for all environment
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  - echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  - DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical sudo apt-get -y update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  - sudo usermod -aG docker ${var.username}
  # Directory for files provisioner
  - sudo mkdir -p /opt/configs && sudo chown ${var.username}.${var.username} /opt/configs && sudo chmod 755 /opt/configs
EOF
}

resource "digitalocean_project_resources" "project" {
  project = data.digitalocean_project.project.id
  resources = [
    digitalocean_droplet.droplet.urn
  ]
  depends_on = [digitalocean_droplet.droplet]
}

resource "null_resource" "cloudinit" {
  triggers = {
    run_always = timestamp()
  }
  connection {
    host    = digitalocean_droplet.droplet.ipv4_address
    user    = var.username
    type    = "ssh"
    agent   = true
    timeout = "3m"
  }
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait",
      "sudo shutdown -r now"
    ]
  }
  depends_on = [digitalocean_droplet.droplet]
}

resource "null_resource" "files" {
  count = can(var.remote_files) && fileset(var.remote_files, "*") != [] ? 1 : 0
  triggers = {
    always_run = timestamp()
  }
  connection {
    host    = digitalocean_droplet.droplet.ipv4_address
    user    = var.username
    type    = "ssh"
    agent   = true
    timeout = "3m"
  }
  provisioner "file" {
    source      = "${var.remote_files}/"
    destination = "/opt/configs"
  }
  depends_on = [null_resource.cloudinit]
}

resource "null_resource" "commands" {
  connection {
    host    = digitalocean_droplet.droplet.ipv4_address
    user    = var.username
    type    = "ssh"
    agent   = true
    timeout = "3m"
  }
  provisioner "remote-exec" {
    inline = var.remote_commands
  }
  depends_on = [null_resource.cloudinit]
}

resource "digitalocean_reserved_ip" "ip" {
  count      = var.droplet_reserved_ip ? 1 : 0
  droplet_id = digitalocean_droplet.droplet.id
  region     = digitalocean_droplet.droplet.region
}

resource "digitalocean_record" "record" {
  count  = var.droplet_dns_record ? 1 : 0
  domain = element(data.digitalocean_domain.domain.*.id, 0)
  type   = "A"
  name   = var.domain_name
  value  = digitalocean_reserved_ip.ip[count.index].ip_address != "" ? digitalocean_reserved_ip.ip[count.index].ip_address : digitalocean_droplet.droplet.ipv4_address
}
