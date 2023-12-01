# Prepare the environment for the application
# Set the environment variables, copy the files and execute the commands

resource "null_resource" "cloudinit" {
  triggers = {
    run_always = timestamp()
  }

  connection {
    host        = digitalocean_droplet.droplet.ipv4_address_private
    user        = "terraform"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = base64decode(var.ssh_private_key)

  }
  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }

  depends_on = [digitalocean_droplet.droplet]
}

resource "null_resource" "set_etc_hosts" {
  count = var.etc_hosts != null && length([for h in var.etc_hosts : h]) > 0 ? 1 : 0

  triggers = {
    hash = sha1(join(",", var.etc_hosts))
  }

  connection {
    host        = digitalocean_droplet.droplet.ipv4_address_private
    user        = "terraform"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = base64decode(var.ssh_private_key)
  }
  
  provisioner "remote-exec" {
    inline = count > 0 ? [
      "echo '${join("\n", var.etc_hosts)}' | sudo tee -a /etc/hosts > /dev/null",
      "echo '${join("\n", var.etc_hosts)}' | sudo tee -a /etc/cloud/templates/hosts.debian.tmpl > /dev/null",
    ] : []
  }

  depends_on = [null_resource.cloudinit]
}

resource "null_resource" "set_environment_variables" {
  count = var.environment_variables != null && length(var.environment_variables) > 0 ? 1 : 0

  triggers = {
    hash = sha1(join(",", var.environment_variables))
  }

  connection {
    host        = digitalocean_droplet.droplet.ipv4_address_private
    user        = "terraform"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = base64decode(var.ssh_private_key)
  }
  provisioner "remote-exec" {
    inline = [
      "echo '${join("\n", var.environment_variables)}' | sudo tee -a /etc/environment > /dev/null"
    ]
  }

  depends_on = [null_resource.cloudinit]
}

resource "null_resource" "copy_files" {
  count = can(var.remote_files) && fileset(var.remote_files, "*") != [] ? 1 : 0

  triggers = {
    always_run = timestamp()
  }

  connection {
    host        = digitalocean_droplet.droplet.ipv4_address_private
    user        = "terraform"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = base64decode(var.ssh_private_key)
  }
  provisioner "file" {
    source      = "${var.remote_files}/"
    destination = "${var.persistent_data_path}/configs"
  }

  depends_on = [null_resource.cloudinit]
}

resource "null_resource" "exec_additional_commands" {
  count = length(coalesce(var.remote_commands, [])) > 0 ? 1 : 0
  triggers = {
    always_run = timestamp()
  }

  connection {
    host        = digitalocean_droplet.droplet.ipv4_address_private
    user        = "terraform"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = base64decode(var.ssh_private_key)
  }
  provisioner "remote-exec" {
    inline = var.remote_commands
  }

  depends_on = [
    null_resource.cloudinit,
    null_resource.set_environment_variables
  ]
}
