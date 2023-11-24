# Provising resources in DigitalOcean
# Droplet, reserved IP, DNS record, volume, volume snapshot

resource "digitalocean_droplet" "droplet" {
  name          = "${var.droplet_name}-${var.droplet_size}-${var.droplet_region}"
  image         = var.droplet_image
  region        = var.droplet_region
  size          = var.droplet_size
  backups       = var.droplet_backups
  monitoring    = var.droplet_monitoring
  droplet_agent = var.droplet_agent
  ssh_keys = [
    data.digitalocean_ssh_key.key.id,
    data.digitalocean_ssh_key.terraform_key.id
  ]
  tags = var.droplet_tags

  user_data = <<EOF
#cloud-config
users:
  - name: ${var.droplet_username}
    groups:
      - sudo
    sudo:
      - ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ${data.digitalocean_ssh_key.key.public_key}
  - name: terraform
    groups:
      - sudo
    sudo:
      - ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - ${data.digitalocean_ssh_key.terraform_key.public_key}

ssh_pwauth: false
disable_root: true
package_update: true
package_upgrade: true
manage_etc_hosts: true
manage_resolv_conf: true

resolv_conf:
  nameservers: ['${var.consul_internal_ip}#${var.consul_internal_port}']
  searchdomains:
    - consul
  options:
    rotate: true
    timeout: 1

packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - software-properties-common
  - net-tools
  - gpg
${var.packages_list != null ? join("\n", formatlist("  - %s", var.packages_list)) : ""}

runcmd:
  # Install docker for all environment
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  - echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  - DEBIAN_FRONTEND=noninteractive DEBIAN_PRIORITY=critical sudo apt-get -y update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  - sudo usermod -aG docker ${var.droplet_username}
  # Directory for configuration files provisioner
  - sudo mkdir -p ${var.persistent_data_path}/configs && sudo chown ${var.droplet_username}.terraform ${var.persistent_data_path}/configs && sudo chmod 775 ${var.persistent_data_path}/configs
EOF
}

resource "digitalocean_project_resources" "project" {
  project = data.digitalocean_project.project.id
  resources = [
    digitalocean_droplet.droplet.urn
  ]

  depends_on = [digitalocean_droplet.droplet]
}

resource "digitalocean_reserved_ip" "ip" {
  count = var.droplet_reserved_ip ? 1 : 0

  droplet_id = digitalocean_droplet.droplet.id
  region     = digitalocean_droplet.droplet.region
}

resource "digitalocean_record" "record" {
  count = var.droplet_dns_record ? 1 : 0

  domain = var.droplet_dns_record ? element(data.digitalocean_domain.domain.*.id, 0) : null
  type   = "A"
  name   = var.droplet_name
  value  = var.droplet_reserved_ip ? digitalocean_reserved_ip.ip[0].ip_address : digitalocean_droplet.droplet.ipv4_address
}

resource "digitalocean_volume" "volume" {
  count = var.additional_volume_size > 0 ? 1 : 0

  region                  = digitalocean_droplet.droplet.region
  name                    = "${var.droplet_name}-${var.droplet_region}-volume"
  size                    = var.additional_volume_size
  initial_filesystem_type = "ext4"
  description             = "Additional volume for ${digitalocean_droplet.droplet.name}"
}

resource "digitalocean_volume_attachment" "volume_attachment" {
  count = var.additional_volume_size > 0 ? 1 : 0

  droplet_id = digitalocean_droplet.droplet.id
  volume_id  = digitalocean_volume.volume[count.index].id
  depends_on = [digitalocean_volume.volume]
}

resource "digitalocean_volume_snapshot" "volume_snapshot" {
  count = var.additional_volume_size > 0 ? 1 : 0

  name      = "${var.droplet_name}--${var.droplet_region}-volume-snapshot"
  volume_id = digitalocean_volume.volume[count.index].id
}
