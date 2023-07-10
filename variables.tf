provider "digitalocean" {
  token = var.digitalocean_token
}

variable "username" {
  description = "Username"
  type        = string
}

variable "password" {
  description = "Password for username"
  type        = string
  sensitive   = true
}

variable "restart_sshd" {
  description = "If you need to restart the sshd server"
  type        = bool
  default     = true
}

variable "remote_commands" {
  description = "List of commands to execute custom remote-exec"
  type        = list()
}

variable "public_key_name" {
  description = "Name of the public key in digital ocean"
  type        = string
}

variable "packages_list" {
  description = "List of packages to install"
  type    = list(string)
}

variable "digitalocean_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive = true
}

variable "droplet_name" {
  description = "The name of the droplet"
  type        = string
  default     = ""
}

variable "droplet_image" {
  description = "The image of the droplet"
  type        = string
  default     = ""
}

variable "droplet_region" {
  description = "The region of the droplet"
  type        = string
  default     = ""
}

variable "droplet_size" {
  description = "The size of the droplet"
  type        = string
}

variable "droplet_tags" {
  description = "The tags of the droplet"
  type        = list
}

variable "droplet_project_name" {
  description = "The target project for the droplet"
  type        = string
}

variable "ansible_playbook" {
  description = "The path to the playbook Ansible file"
  type        = string
  default     = "ansible/playbook.yml"
}