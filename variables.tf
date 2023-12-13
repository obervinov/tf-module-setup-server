variable "droplet_username" {
  description = "Name for creating a new user"
  type        = string
}

variable "droplet_name" {
  description = "The name of the droplet"
  type        = string
  default     = "server-0001"
}

variable "droplet_image" {
  description = "The image of the droplet"
  type        = string
  default     = "ubuntu-23-04-x64"
}

variable "droplet_region" {
  description = "The region of the droplet"
  type        = string
  default     = "ams3"
}

variable "droplet_size" {
  description = "The size of the droplet"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "droplet_tags" {
  description = "The tags of the droplet"
  type        = list(any)
}

variable "droplet_project" {
  description = "The target project for the droplet"
  type        = string
}

variable "droplet_reserved_ip" {
  description = "Link a reserved address to a droplet"
  type        = bool
  default     = false
}

variable "droplet_dns" {
  description = "Create an external dns record for this droplet in `droplet_dns_zone`"
  type        = bool
  default     = true
}

variable "droplet_dns_zone" {
  description = "Name of the domain zone to create an external dns record"
  type        = string
  default     = ""
}

variable "droplet_volume_size" {
  description = "Additional volume size (if required)"
  type        = number
  default     = 0
}

variable "droplet_backups" {
  description = "Enable backups for droplet"
  type        = bool
  default     = false
}

variable "droplet_monitoring" {
  description = "Enable monitoring for droplet"
  type        = bool
  default     = true
}

variable "droplet_ssh_key" {
  description = "Private key for ssh connection in Terraform Cloud (base64)"
  type        = string
}

variable "droplet_agent" {
  description = "Enable agent for droplet"
  type        = bool
  default     = true
}

variable "droplet_vpc" {
  description = "VPC name"
  type        = string
  default     = "default"
}

variable "os_packages" {
  description = "List of packages to install"
  type        = list(string)
  default     = []
}

variable "os_commands" {
  description = "List of commands to execute custom remote-exec"
  type        = list(string)
  default     = null
}

variable "os_environment_variables" {
  description = "List with environmetn variables for server"
  type        = list(any)
  default     = []
}

variable "os_consul_agent" {
  description = "Consul agent configuration for services registration"
  type = object({
    enabled = bool
    services = list(object({
      name = string
      port = number
      check = object({
        http   = string
        status = string
      })
    }))
  })
  default = {
    "default" = {
      enabled = false
      services = []
    }
  }
}


variable "os_swap_size" {
  description = "Size of swap in GB"
  type        = number
  default     = 0
}

variable "os_nameservers" {
  description = "Private IPs for cloudinit nameserver"
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "os_hosts" {
  description = "List with /etc/hosts"
  type        = list(string)
  default     = []
}

variable "os_loki" {
  type = map(object({
    enabled = bool
    version = string
    url     = string
    })
  )
  default = {
    "default" = {
      enabled = false
      version = "2.8.7"
      url     = "http://loki:3100"
    }
  }
}

variable "app_data" {
  description = "The path to the directory for storing persistent information and configurations"
  type        = string
  default     = "/opt"
}

variable "app_configurations" {
  description = "The path to the directories with configurations that will be copied to the created server"
  type        = string
  default     = "configs/"
}

variable "app_cname_records" {
  description = "List with CNAME records for droplet"
  type        = list(string)
  default     = []
}