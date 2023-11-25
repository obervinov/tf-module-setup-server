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

resource "null_resource" "set_environment_variables" {
  count = var.environment_variables != null && length(var.environment_variables) > 0 ? 1 : 0

  triggers = {
    always = timestamp()
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
  count = var.remote_commands != null && length(var.remote_commands) > 0 ? 1 : 0
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
