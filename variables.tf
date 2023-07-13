provider "digitalocean" {
  token = var.digitalocean_token
}

variable "username" {
  description = "Name for creating a new user"
  type        = string
}

variable "packages_list" {
  description = "List of packages to install"
  type        = list(string)
}

variable "remote_commands" {
  description = "List of commands to execute custom remote-exec"
  type        = list(string)
}

variable "configs_path" {
  description = "The path to the directories with configurations that will be copied to the created server"
  type        = string
  default     = "configs/"
}

variable "public_key_name" {
  description = "Name of the public key in digitalocean"
  type        = string
}

variable "digitalocean_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
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
  type        = list(any)
}

variable "droplet_project_name" {
  description = "The target project for the droplet"
  type        = string
}
