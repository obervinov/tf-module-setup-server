# Provising resources in DigitalOcean
# Droplet, reserved IP, DNS record, volume, volume snapshot
resource "digitalocean_droplet" "default" {
  name          = "${var.droplet_name}-${var.droplet_size}-${var.droplet_region}"
  image         = var.droplet_image
  region        = var.droplet_region
  size          = var.droplet_size
  backups       = var.droplet_backups
  monitoring    = var.droplet_monitoring
  droplet_agent = var.droplet_agent
  vpc_uuid      = data.digitalocean_vpc.default.id

  ssh_keys = [
    data.digitalocean_ssh_key.default.id,
    data.digitalocean_ssh_key.ci_cd.id
  ]

  tags      = var.droplet_tags
  user_data = local.user_data
}

resource "digitalocean_project_resources" "default" {
  project = data.digitalocean_project.default.id
  resources = [
    digitalocean_droplet.default.urn
  ]

  depends_on = [
    digitalocean_droplet.default
  ]
}

resource "digitalocean_reserved_ip" "default" {
  count = var.droplet_reserved_ip ? 1 : 0

  droplet_id = digitalocean_droplet.default.id
  region     = digitalocean_droplet.default.region
}

resource "digitalocean_record" "default" {
  count = var.droplet_dns ? 1 : 0

  domain = var.droplet_dns ? element(data.digitalocean_domain.default.*.id, 0) : null
  type   = "A"
  name   = var.droplet_name
  value  = var.droplet_reserved_ip ? digitalocean_reserved_ip.default[0].ip_address : digitalocean_droplet.default.ipv4_address
}

resource "digitalocean_record" "additional" {
  for_each = length(var.app_cname_records) > 0 ? var.app_cname_records : tolist([])

  domain = element(data.digitalocean_domain.default.*.id, 0)
  type   = "CNAME"
  name   = each.value
  value  = digitalocean_record.default[count.index].fqdn

  depends_on = [
    digitalocean_record.default
  ]
}

resource "digitalocean_volume" "default" {
  count = var.droplet_volume_size > 0 ? 1 : 0

  region                  = digitalocean_droplet.default.region
  name                    = "${var.droplet_name}-${var.droplet_region}-volume"
  size                    = var.droplet_volume_size
  initial_filesystem_type = "ext4"
  description             = "Additional volume for ${digitalocean_droplet.default.name}"
}

resource "digitalocean_volume_attachment" "default" {
  count = var.droplet_volume_size > 0 ? 1 : 0

  droplet_id = digitalocean_droplet.default.id
  volume_id  = digitalocean_volume.default[count.index].id

  depends_on = [
    digitalocean_volume.default
  ]
}

resource "digitalocean_volume_snapshot" "default" {
  count = var.droplet_volume_size > 0 ? 1 : 0

  name      = "${var.droplet_name}--${var.droplet_region}-volume-snapshot"
  volume_id = digitalocean_volume.default[count.index].id
}
