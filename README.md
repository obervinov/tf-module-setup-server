# tf-module-setup-server
[![Release](https://github.com/obervinov/tf-module-setup-server/actions/workflows/release.yml/badge.svg)](https://github.com/obervinov/tf-module-setup-server/actions/workflows/release.yml)
[![CodeQL](https://github.com/obervinov/tf-module-setup-server/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/obervinov/tf-module-setup-server/actions/workflows/github-code-scanning/codeql)
[![Tests and checks](https://github.com/obervinov/tf-module-setup-server/actions/workflows/tests.yml/badge.svg?branch=main&event=pull_request)](https://github.com/obervinov/tf-module-setup-server/actions/workflows/tests.yml)
[![Build](https://github.com/obervinov/tf-module-setup-server/actions/workflows/build.yml/badge.svg?branch=main&event=pull_request)](https://github.com/obervinov/tf-module-setup-server/actions/workflows/build.yml)

![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/obervinov/tf-module-setup-server?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/obervinov/tf-module-setup-server?style=for-the-badge)
![GitHub Release Date](https://img.shields.io/github/release-date/obervinov/tf-module-setup-server?style=for-the-badge)
![GitHub issues](https://img.shields.io/github/issues/obervinov/tf-module-setup-server?style=for-the-badge)
![GitHub repo size](https://img.shields.io/github/repo-size/obervinov/tf-module-setup-server?style=for-the-badge)
![PyPI - Python Version](https://img.shields.io/pypi/pyversions/instaloader?style=for-the-badge)


## <img src="https://github.com/obervinov/_templates/blob/main/icons/github-actions.png" width="25" title="github-actions"> GitHub Actions

| Name  | Version |
| ------------------------ | ----------- |
| GitHub Actions Templates | [v1.0.5](https://github.com/obervinov/_templates/tree/v1.0.5) |


## <img src="https://github.com/obervinov/_templates/blob/main/icons/book.png" width="25" title="about"> About this project
This terraform module is designed to simplify the deployment of droplets and all related components in DigitalOcean for my infrastructure.

It performs tasks such as:
- Creating a droplet
- Creating dns records
- Creating reserved IP addresses
- Creating additional volumes
- Adding users and ssh keys
- Configuring the OS environment 
- Adding application configurations
- Launching applications
- Registration of servers and services in the consul



## <img src="https://github.com/obervinov/_templates/blob/main/icons/config.png" width="25" title="usage"> Usage example
```hcl
module "prepare_environment" {
  source                 = "git@github.com:obervinov/tf-module-setup-server.git/?ref=release/v1.0.0"

  droplet_username         = var.ssh_username
  droplet_ssh_key          = var.ssh_private_key
  droplet_name             = "consul"
  droplet_tags             = ["ssh", "nginx"]
  droplet_project          = "myproject1"
  droplet_size             = "s-1vcpu-512mb-1gb"
  droplet_image            = data.digitalocean_droplet_snapshot.default.id
  domain_dns_zone          = var.domain_zone
  droplet_vpc              = "default-vpc"
  droplet_volume_size      = 10
  os_consul_agent          = false
  os_environment_variables = ["ENV1=value1", "ENV2=value2"]
  os_commands = [
    "hostname -a",
    "lsb_release"
  ]
}
```

