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
This module performs the initial creation of a server in digitalocean, as well as performs basic preparation of the environment:

* create user
* install packages
* configuring sshd
* copy files
* custom remote commands

## <img src="https://github.com/obervinov/_templates/blob/main/icons/config.png" width="25" title="usage"> Usage example
```hcl
module "prepare_environment" {
  source                 = "git@github.com:obervinov/tf-module-setup-server.git/?ref=release/v1.0.0"

  droplet_username    = var.ssh_username
  droplet_ssh_key     = var.ssh_private_key
  droplet_name        = local.name
  droplet_tags        = ["web", "ssh", "ubuntu"]
  droplet_project     = "myproject1"
  droplet_size        = "s-1vcpu-1gb"
  droplet_image       = "ubuntu-23-10-x64"
  droplet_dns_zone    = var.domain_zone
  droplet_vpc         = "default-vpc"
  droplet_volume_size = 5
  droplet_reserved_ip = true

  os_swap_size = 1
  os_consul_registration_service = {
    name = "webapp1"
    port = 443
    check = {
      http   = "http://webapp.exaple.com:443/health"
      status = "passing"
    }
  }

  os_environment_variables = [
    "ACME_DOMAIN=${var.domain_zone}",
    "ACME_EMAIL=${var.acme_email}"
  ]
  os_commands = [
    "sudo docker compose -f /opt/configs/docker-compose.yml up -d --remove-orphans --force-recreate",
  ]

  app_cname_records = [
    "webapp1",
    "webapp2"
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2 |
| <a name="requirement_consul"></a> [consul](#requirement\_consul) | 2.20.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.28.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_consul"></a> [consul](#provider\_consul) | 2.20.0 |
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.28.1 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [consul_acl_policy.default](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/acl_policy) | resource |
| [consul_acl_token.node](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/acl_token) | resource |
| [consul_node.default](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/node) | resource |
| [consul_service.default](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/service) | resource |
| [digitalocean_droplet.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_project_resources.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_record.additional](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/record) | resource |
| [digitalocean_record.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/record) | resource |
| [digitalocean_reserved_ip.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/reserved_ip) | resource |
| [digitalocean_volume.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume_attachment.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_volume_snapshot.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_snapshot) | resource |
| [null_resource.additional_commands](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.cloudinit](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.consul_token_enviroment](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.environment_variables](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.etc_hosts](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.files](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.loki](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.resolved_conf](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.swap](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [consul_acl_token_secret_id.default](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/data-sources/acl_token_secret_id) | data source |
| [digitalocean_domain.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/domain) | data source |
| [digitalocean_project.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/project) | data source |
| [digitalocean_ssh_key.ci_cd](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |
| [digitalocean_ssh_key.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |
| [digitalocean_vpc.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_cname_records"></a> [app\_cname\_records](#input\_app\_cname\_records) | List with CNAME records for droplet | `list(string)` | `[]` | no |
| <a name="input_app_configurations"></a> [app\_configurations](#input\_app\_configurations) | The path to the directories with configurations that will be copied to the created server | `string` | `"configs/"` | no |
| <a name="input_app_data"></a> [app\_data](#input\_app\_data) | The path to the directory for storing persistent information and configurations | `string` | `"/opt"` | no |
| <a name="input_droplet_agent"></a> [droplet\_agent](#input\_droplet\_agent) | Enable agent for droplet | `bool` | `true` | no |
| <a name="input_droplet_backups"></a> [droplet\_backups](#input\_droplet\_backups) | Enable backups for droplet | `bool` | `false` | no |
| <a name="input_droplet_dns"></a> [droplet\_dns](#input\_droplet\_dns) | Create an external dns record for this droplet in `droplet_dns_zone` | `bool` | `true` | no |
| <a name="input_droplet_dns_zone"></a> [droplet\_dns\_zone](#input\_droplet\_dns\_zone) | Name of the domain zone to create an external dns record | `string` | `""` | no |
| <a name="input_droplet_image"></a> [droplet\_image](#input\_droplet\_image) | The image of the droplet | `string` | `"ubuntu-23-04-x64"` | no |
| <a name="input_droplet_monitoring"></a> [droplet\_monitoring](#input\_droplet\_monitoring) | Enable monitoring for droplet | `bool` | `true` | no |
| <a name="input_droplet_name"></a> [droplet\_name](#input\_droplet\_name) | The name of the droplet | `string` | `"server-0001"` | no |
| <a name="input_droplet_project"></a> [droplet\_project](#input\_droplet\_project) | The target project for the droplet | `string` | n/a | yes |
| <a name="input_droplet_region"></a> [droplet\_region](#input\_droplet\_region) | The region of the droplet | `string` | `"ams3"` | no |
| <a name="input_droplet_reserved_ip"></a> [droplet\_reserved\_ip](#input\_droplet\_reserved\_ip) | Link a reserved address to a droplet | `bool` | `false` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | The size of the droplet | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_droplet_ssh_key"></a> [droplet\_ssh\_key](#input\_droplet\_ssh\_key) | Private key for ssh connection in Terraform Cloud (base64) | `string` | n/a | yes |
| <a name="input_droplet_tags"></a> [droplet\_tags](#input\_droplet\_tags) | The tags of the droplet | `list(any)` | n/a | yes |
| <a name="input_droplet_username"></a> [droplet\_username](#input\_droplet\_username) | Name for creating a new user | `string` | n/a | yes |
| <a name="input_droplet_volume_size"></a> [droplet\_volume\_size](#input\_droplet\_volume\_size) | Additional volume size (if required) | `number` | `0` | no |
| <a name="input_droplet_vpc"></a> [droplet\_vpc](#input\_droplet\_vpc) | VPC name | `string` | `"default"` | no |
| <a name="input_os_commands"></a> [os\_commands](#input\_os\_commands) | List of commands to execute custom remote-exec | `list(string)` | `null` | no |
| <a name="input_os_consul_agent"></a> [os\_consul\_agent](#input\_os\_consul\_agent) | Consul agent configuration for services registration | <pre>object({<br>    enabled = bool<br>    services = list(object({<br>      name = string<br>      port = number<br>      check = object({<br>        http   = string<br>        status = string<br>      })<br>    }))<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "services": []<br>}</pre> | no |
| <a name="input_os_environment_variables"></a> [os\_environment\_variables](#input\_os\_environment\_variables) | List with environmetn variables for server | `list(any)` | `[]` | no |
| <a name="input_os_hosts"></a> [os\_hosts](#input\_os\_hosts) | List with /etc/hosts | `list(string)` | `[]` | no |
| <a name="input_os_loki"></a> [os\_loki](#input\_os\_loki) | n/a | <pre>object({<br>    enabled = bool<br>    version = string<br>    url     = string<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "url": "http://loki:3100",<br>  "version": "2.8.7"<br>}</pre> | no |
| <a name="input_os_packages"></a> [os\_packages](#input\_os\_packages) | List of packages to install | `list(string)` | `[]` | no |
| <a name="input_os_resolved_conf"></a> [os\_resolved\_conf](#input\_os\_resolved\_conf) | List with DNS servers and domains for /etc/systemd/resolved.conf | <pre>object({<br>    nameservers = string,<br>    domains     = string<br>  })</pre> | `null` | no |
| <a name="input_os_swap_size"></a> [os\_swap\_size](#input\_os\_swap\_size) | Size of swap in GB | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_volume"></a> [additional\_volume](#output\_additional\_volume) | Additional volume for new droplet |
| <a name="output_app_cname_records"></a> [app\_cname\_records](#output\_app\_cname\_records) | n/a |
| <a name="output_droplet_dns_record"></a> [droplet\_dns\_record](#output\_droplet\_dns\_record) | Public dns record for new droplet |
| <a name="output_droplet_external_ip"></a> [droplet\_external\_ip](#output\_droplet\_external\_ip) | Droplet external ip-address |
| <a name="output_droplet_id"></a> [droplet\_id](#output\_droplet\_id) | Droplet id |
| <a name="output_droplet_name"></a> [droplet\_name](#output\_droplet\_name) | Droplet name |
| <a name="output_droplet_private_ip"></a> [droplet\_private\_ip](#output\_droplet\_private\_ip) | Private ip for new droplet |
| <a name="output_droplet_reserved_ip"></a> [droplet\_reserved\_ip](#output\_droplet\_reserved\_ip) | Reserved ip for new droplet |
| <a name="output_droplet_ssh_key_fingerprint"></a> [droplet\_ssh\_key\_fingerprint](#output\_droplet\_ssh\_key\_fingerprint) | SSH Key fingerprint |
| <a name="output_droplet_username"></a> [droplet\_username](#output\_droplet\_username) | Username for new user |
| <a name="output_persistent_data_path"></a> [persistent\_data\_path](#output\_persistent\_data\_path) | The path to the directory for storing persistent information and configurations |
