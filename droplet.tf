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
  vpc_uuid      = data.digitalocean_vpc.vpc.id
  ssh_keys = [
    data.digitalocean_ssh_key.key.id,
    data.digitalocean_ssh_key.terraform_key.id
  ]
  tags      = var.droplet_tags
  user_data = local.user_data
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
