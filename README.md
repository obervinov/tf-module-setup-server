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

  droplet_username       = var.ssh_username
  ssh_private_key        = var.ssh_private_key
  droplet_name           = "database"
  droplet_tags           = ["postgres", "ssh"]
  droplet_project_name   = "my-project-1"
  domain_zone            = "example.com"
  droplet_backups        = true
  additional_volume_size = 10
  packages_list          = ["python3", "libsecret-tools", "python3-pip"]
  environment_variables  = ["ENV1=VALUE1", "ENV2=VALUE2"]
  consul_service_port    = 5432
  remote_commands = [
    "hostname -a",
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
| [consul_acl_policy.node_policy](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/acl_policy) | resource |
| [consul_acl_policy.service_policy](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/acl_policy) | resource |
| [consul_acl_token.acl_token](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/acl_token) | resource |
| [consul_node.default](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/node) | resource |
| [consul_service.default](https://registry.terraform.io/providers/hashicorp/consul/2.20.0/docs/resources/service) | resource |
| [digitalocean_droplet.droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_project_resources.project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_record.record](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/record) | resource |
| [digitalocean_reserved_ip.ip](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/reserved_ip) | resource |
| [digitalocean_volume.volume](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume) | resource |
| [digitalocean_volume_attachment.volume_attachment](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_attachment) | resource |
| [digitalocean_volume_snapshot.volume_snapshot](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/volume_snapshot) | resource |
| [null_resource.cloudinit](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.copy_files](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.exec_additional_commands](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.set_environment_variables](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.set_etc_hosts](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.setup_env_consul_agent_token](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [digitalocean_domain.domain](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/domain) | data source |
| [digitalocean_project.project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/project) | data source |
| [digitalocean_ssh_key.key](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |
| [digitalocean_ssh_key.terraform_key](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |
| [digitalocean_vpc.vpc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_volume_size"></a> [additional\_volume\_size](#input\_additional\_volume\_size) | Additional volume size (if required) | `number` | `0` | no |
| <a name="input_consul_agent"></a> [consul\_agent](#input\_consul\_agent) | Enable consul agent and registration service in Consul | `bool` | `true` | no |
| <a name="input_consul_service_check"></a> [consul\_service\_check](#input\_consul\_service\_check) | Check for registration service in consul | <pre>object({<br>    check_id                          = string<br>    name                              = string<br>    http                              = string<br>    status                            = string<br>    tls_skip_verify                   = bool<br>    method                            = string<br>    interval                          = string<br>    timeout                           = string<br>    deregister_critical_service_after = string<br>  })</pre> | `null` | no |
| <a name="input_consul_service_port"></a> [consul\_service\_port](#input\_consul\_service\_port) | Port for registration service in consul | `number` | `80` | no |
| <a name="input_domain_zone"></a> [domain\_zone](#input\_domain\_zone) | Name of the domain zone to create record | `string` | `""` | no |
| <a name="input_droplet_agent"></a> [droplet\_agent](#input\_droplet\_agent) | Enable agent for droplet | `bool` | `true` | no |
| <a name="input_droplet_backups"></a> [droplet\_backups](#input\_droplet\_backups) | Enable backups for droplet | `bool` | `false` | no |
| <a name="input_droplet_dns_record"></a> [droplet\_dns\_record](#input\_droplet\_dns\_record) | Create a dns record for this droplet | `bool` | `true` | no |
| <a name="input_droplet_image"></a> [droplet\_image](#input\_droplet\_image) | The image of the droplet | `string` | `"ubuntu-23-04-x64"` | no |
| <a name="input_droplet_monitoring"></a> [droplet\_monitoring](#input\_droplet\_monitoring) | Enable monitoring for droplet | `bool` | `true` | no |
| <a name="input_droplet_name"></a> [droplet\_name](#input\_droplet\_name) | The name of the droplet | `string` | `"server-0001"` | no |
| <a name="input_droplet_project_name"></a> [droplet\_project\_name](#input\_droplet\_project\_name) | The target project for the droplet | `string` | n/a | yes |
| <a name="input_droplet_region"></a> [droplet\_region](#input\_droplet\_region) | The region of the droplet | `string` | `"ams3"` | no |
| <a name="input_droplet_reserved_ip"></a> [droplet\_reserved\_ip](#input\_droplet\_reserved\_ip) | Link a reserved address to a droplet | `bool` | `false` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | The size of the droplet | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_droplet_tags"></a> [droplet\_tags](#input\_droplet\_tags) | The tags of the droplet | `list(any)` | n/a | yes |
| <a name="input_droplet_username"></a> [droplet\_username](#input\_droplet\_username) | Name for creating a new user | `string` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | List with environmetn variables for server | `list(any)` | `null` | no |
| <a name="input_etc_hosts"></a> [etc\_hosts](#input\_etc\_hosts) | List with etc hosts | `list(string)` | `null` | no |
| <a name="input_nameserver_ips"></a> [nameserver\_ips](#input\_nameserver\_ips) | Private IPs for cloudinit nameserver | `list(string)` | <pre>[<br>  "8.8.8.8",<br>  "8.8.4.4"<br>]</pre> | no |
| <a name="input_packages_list"></a> [packages\_list](#input\_packages\_list) | List of packages to install | `list(string)` | `[]` | no |
| <a name="input_persistent_data_path"></a> [persistent\_data\_path](#input\_persistent\_data\_path) | The path to the directory for storing persistent information and configurations | `string` | `"/opt"` | no |
| <a name="input_remote_commands"></a> [remote\_commands](#input\_remote\_commands) | List of commands to execute custom remote-exec | `list(string)` | `null` | no |
| <a name="input_remote_files"></a> [remote\_files](#input\_remote\_files) | The path to the directories with configurations that will be copied to the created server | `string` | `"configs/"` | no |
| <a name="input_ssh_private_key"></a> [ssh\_private\_key](#input\_ssh\_private\_key) | Private key for ssh connection in Terraform Cloud (base64) | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC name | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_volume"></a> [additional\_volume](#output\_additional\_volume) | Additional volume for new droplet |
| <a name="output_droplet_dns_record"></a> [droplet\_dns\_record](#output\_droplet\_dns\_record) | Public dns record for new droplet |
| <a name="output_droplet_external_ip"></a> [droplet\_external\_ip](#output\_droplet\_external\_ip) | Droplet external ip-address |
| <a name="output_droplet_name"></a> [droplet\_name](#output\_droplet\_name) | Droplet name |
| <a name="output_droplet_private_ip"></a> [droplet\_private\_ip](#output\_droplet\_private\_ip) | Private ip for new droplet |
| <a name="output_droplet_reserved_ip"></a> [droplet\_reserved\_ip](#output\_droplet\_reserved\_ip) | Reserved ip for new droplet |
| <a name="output_droplet_ssh_key_fingerprint"></a> [droplet\_ssh\_key\_fingerprint](#output\_droplet\_ssh\_key\_fingerprint) | SSH Key fingerprint |
| <a name="output_droplet_username"></a> [droplet\_username](#output\_droplet\_username) | Username for new user |
| <a name="output_persistent_data_path"></a> [persistent\_data\_path](#output\_persistent\_data\_path) | The path to the directory for storing persistent information and configurations |
