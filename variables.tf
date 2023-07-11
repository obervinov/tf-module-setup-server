provider "digitalocean" {
  token = var.digitalocean_token
}

variable "username" {
  description = "Name for creating a new user"
  type        = string
}

variable "password_hash" {
  description = "Hash of the password to create a new user"
  type = string
  default = null_resource.password_hash.*.stdout[0]
}

variable "remote_commands" {
  description = "List of commands to execute custom remote-exec"
  type        = list(string)
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
