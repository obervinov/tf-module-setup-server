# Prepare the environment for the application
# Set the environment variables, copy the files and execute the commands

resource "null_resource" "cloudinit" {
  triggers = {
    run_always = timestamp()
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
      "cloud-init status --wait"
    ]
  }

  depends_on = [
    digitalocean_droplet.default
  ]
}

resource "null_resource" "etc_hosts" {
  count = var.os_hosts != null && length(var.os_hosts) > 0 ? 1 : 0

  triggers = {
    hash = sha1(join(",", var.os_hosts))
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
      "echo '${join("\n", var.os_hosts)}' | sudo tee -a /etc/hosts > /dev/null",
      "echo '${join("\n", var.os_hosts)}' | sudo tee -a /etc/cloud/templates/hosts.debian.tmpl > /dev/null",
    ]
  }

  depends_on = [
    null_resource.cloudinit
  ]
}

resource "null_resource" "environment_variables" {
  count = var.os_environment_variables != null && length(var.os_environment_variables) > 0 ? 1 : 0

  triggers = {
    hash = sha1(join(",", var.os_environment_variables))
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
      "echo '${join("\n", var.os_environment_variables)}' | sudo tee -a /etc/environment > /dev/null"
    ]
  }

  depends_on = [
    null_resource.cloudinit
  ]
}

resource "null_resource" "files" {
  count = can(var.app_configurations) && fileset(var.app_configurations, "*") != [] ? 1 : 0

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
  provisioner "file" {
    source      = "${var.app_configurations}/"
    destination = "${var.app_data}/${var.app_configurations}"
  }

  depends_on = [
    null_resource.cloudinit
  ]
}

resource "null_resource" "additional_commands" {
  count = length(coalesce(var.os_commands, [])) > 0 ? 1 : 0
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
    inline = var.os_commands
  }

  depends_on = [
    null_resource.cloudinit,
    null_resource.files,
    null_resource.etc_hosts,
    null_resource.environment_variables
  ]
}
