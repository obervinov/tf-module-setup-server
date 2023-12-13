
# Create acl policies, tokens, nodes, and services based on os_consul_agent
resource "consul_acl_policy" "node" {
  count = var.os_consul_agent.enabled ? 1 : 0

  name        = "node-policy-${var.os_consul_agent[count.index].name}"
  description = "Policy for ${var.os_consul_agent[count.index].name} server"
  rules       = <<-EOT
    node_prefix "" {
      policy = "write"
    }
  EOT

  depends_on = [
    null_resource.cloudinit,
    null_resource.additional_commands
  ]
}

# Create acl policy for registering services
resource "consul_acl_policy" "service" {
  count = var.os_consul_agent.enabled ? 1 : 0

  name        = "service-policy-${var.os_consul_agent[count.index].name}"
  description = "Policy for ${var.os_consul_agent[count.index].name} service"
  rules       = <<-EOT
    service_prefix "" {
      policy = "write"
    }
  EOT

  depends_on = [
    null_resource.cloudinit,
    null_resource.additional_commands
  ]
}

# Create acl token for registering nodes and services
resource "consul_acl_token" "node" {
  count = var.os_consul_agent.enabled ? 1 : 0

  description = "ACL Token for ${var.droplet_name} register and service policies"
  local       = true
  policies = [
    consul_acl_policy.node[count.index].name,
    consul_acl_policy.service[count.index].name,
  ]
  node_identities {
    node_name  = var.droplet_name
    datacenter = var.droplet_region
  }
  service_identities {
    service_name = var.os_consul_agent[count.index].name
  }

  depends_on = [
    null_resource.cloudinit,
    null_resource.additional_commands
  ]
}

# Register the droplet as a Consul node and service
resource "consul_node" "default" {
  count = var.os_consul_agent.enabled ? 1 : 0

  name       = digitalocean_droplet.default.name
  address    = digitalocean_droplet.default.ipv4_address_private
  datacenter = var.droplet_region

  depends_on = [
    null_resource.cloudinit,
    null_resource.additional_commands
  ]
}

resource "consul_service" "default" {
  for_each = { for service in var.os_consul_agent.services : service.name => service }

  node       = consul_node.default[0].name
  name       = each.value.name
  tags       = var.droplet_tags
  port       = each.value.port
  address    = digitalocean_droplet.default.ipv4_address_private
  datacenter = var.droplet_region

  check {
    check_id                          = each.value.name
    name                              = "HTTP on port ${each.value.port} for ${each.value.name}"
    http                              = each.value.check.http
    status                            = each.value.check.status
    method                            = "GET"
    interval                          = "10s"
    timeout                           = "1s"
    deregister_critical_service_after = "30s"
  }

  depends_on = [
    consul_node.default
  ]
}

resource "null_resource" "consul_token_enviroment" {
  count = var.os_consul_agent.enabled ? 1 : 0

  triggers = {
    always_run = timestamp()
  }

  connection {
    host        = digitalocean_droplet.default.ipv4_address_private
    user        = "terraform"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = base64decode(var.droplet_ssh_key)
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'CONSUL_HTTP_TOKEN=${data.consul_acl_token_secret_id.default[0].secret_id}' | sudo tee -a /etc/environment > /dev/null"
    ]
  }

  depends_on = [
    consul_acl_token.node
  ]
}
