# Register the droplet as a Consul node and service

resource "consul_node" "default" {
  count = var.consul_service_port != 0 ? 1 : 0

  name       = digitalocean_droplet.droplet.name
  address    = digitalocean_droplet.droplet.ipv4_address_private
  datacenter = var.droplet_region

  depends_on = [
    null_resource.cloudinit,
    null_resource.exec_additional_commands
  ]
}

resource "consul_service" "default" {
  count = var.consul_service_port != 0 ? 1 : 0

  node       = consul_node.default[0].name
  name       = var.droplet_name
  tags       = var.droplet_tags
  port       = var.consul_service_port
  address    = digitalocean_droplet.droplet.ipv4_address_private
  datacenter = var.droplet_region

  check {
    check_id                          = var.consul_service_check.check_id
    name                              = var.consul_service_check.name
    http                              = var.consul_service_check.http
    status                            = var.consul_service_check.status
    tls_skip_verify                   = var.consul_service_check.tls_skip_verify
    method                            = var.consul_service_check.method
    interval                          = var.consul_service_check.interval
    timeout                           = var.consul_service_check.timeout
    deregister_critical_service_after = var.consul_service_check.deregister_critical_service_after
  }

  depends_on = [
    consul_node.default
  ]
}
