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
| GitHub Actions Templates | [v1.0.4](https://github.com/obervinov/_templates/tree/v1.0.4) |


## <img src="https://github.com/obervinov/_templates/blob/main/icons/book.png" width="25" title="about"> About this project
This module performs the initial creation of a server in digitalocean, as well as performs basic preparation of the environment:

* create user
* install packages
* configuring sshd
* copy files
* custom remote commands

## <img src="https://github.com/obervinov/_templates/blob/main/icons/stack.png" width="25" title="stack"> Repository map

```sh
.
├── CHANGELOG.md
├── LICENSE
├── README.md
├── SECURITY.md
├── data.tf
├── main.tf
├── output.tf
├── providers.tf
├── variables.tf
└── versions.tf
```

## <img src="https://github.com/obervinov/_templates/blob/main/icons/requirements.png" width="25" title="requirements"> Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.2 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.28.1 |

## <img src="https://github.com/obervinov/_templates/blob/main/icons/file.png" width="18" title="porviders"> Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.28.1 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## <img src="https://github.com/obervinov/_templates/blob/main/icons/config.png" width="25" title="resources">  Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_project_resources.project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project_resources) | resource |
| [digitalocean_record.record](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/record) | resource |
| [digitalocean_reserved_ip.ip](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/reserved_ip) | resource |
| [null_resource.cloudinit](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.commands](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.files](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [digitalocean_domain.domain](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/domain) | data source |
| [digitalocean_project.project](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/project) | data source |
| [digitalocean_ssh_key.key](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_key) | data source |

## <img src="https://github.com/obervinov/_templates/blob/main/icons/build.png" width="25" title="inputs"> Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_digitalocean_token"></a> [digitalocean\_token](#input\_digitalocean\_token) | DigitalOcean API Token | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Name of the new domain to create the record | `string` | `""` | no |
| <a name="input_domain_zone"></a> [domain\_zone](#input\_domain\_zone) | Name of the domain zone to create record | `string` | `""` | no |
| <a name="input_droplet_dns_record"></a> [droplet\_dns\_record](#input\_droplet\_dns\_record) | Create a dns record for this droplet | `bool` | `false` | no |
| <a name="input_droplet_image"></a> [droplet\_image](#input\_droplet\_image) | The image of the droplet | `string` | `""` | no |
| <a name="input_droplet_name"></a> [droplet\_name](#input\_droplet\_name) | The name of the droplet | `string` | `""` | no |
| <a name="input_droplet_project_name"></a> [droplet\_project\_name](#input\_droplet\_project\_name) | The target project for the droplet | `string` | n/a | yes |
| <a name="input_droplet_region"></a> [droplet\_region](#input\_droplet\_region) | The region of the droplet | `string` | `""` | no |
| <a name="input_droplet_reserved_ip"></a> [droplet\_reserved\_ip](#input\_droplet\_reserved\_ip) | Link a reserved address to a droplet | `bool` | `false` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | The size of the droplet | `string` | n/a | yes |
| <a name="input_droplet_tags"></a> [droplet\_tags](#input\_droplet\_tags) | The tags of the droplet | `list(any)` | n/a | yes |
| <a name="input_packages_list"></a> [packages\_list](#input\_packages\_list) | List of packages to install | `list(string)` | n/a | yes |
| <a name="input_public_key_name"></a> [public\_key\_name](#input\_public\_key\_name) | Name of the public key in digitalocean | `string` | n/a | yes |
| <a name="input_remote_commands"></a> [remote\_commands](#input\_remote\_commands) | List of commands to execute custom remote-exec | `list(string)` | n/a | yes |
| <a name="input_remote_files"></a> [remote\_files](#input\_remote\_files) | The path to the directories with configurations that will be copied to the created server | `string` | `"configs/"` | no |
| <a name="input_username"></a> [username](#input\_username) | Name for creating a new user | `string` | n/a | yes |

## <img src="https://github.com/obervinov/_templates/blob/main/icons/stack2.png" width="25" title="outputs"> Outputs

| Name | Description |
|------|-------------|
| <a name="output_droplet_dns_record"></a> [droplet\_dns\_record](#output\_droplet\_dns\_record) | Public dns record for new droplet |
| <a name="output_droplet_external_ip"></a> [droplet\_external\_ip](#output\_droplet\_external\_ip) | Droplet external ip-address |
| <a name="output_droplet_name"></a> [droplet\_name](#output\_droplet\_name) | Droplet name |
| <a name="output_droplet_private_ip"></a> [droplet\_private\_ip](#output\_droplet\_private\_ip) | Private ip for new droplet |
| <a name="output_droplet_reserved_ip"></a> [droplet\_reserved\_ip](#output\_droplet\_reserved\_ip) | Reserved ip for new droplet |
| <a name="output_droplet_ssh_key_fingerprint"></a> [droplet\_ssh\_key\_fingerprint](#output\_droplet\_ssh\_key\_fingerprint) | SSH Key fingerprint |
| <a name="output_droplet_username"></a> [droplet\_username](#output\_droplet\_username) | Username for new user |

## <img src="https://github.com/obervinov/_templates/blob/main/icons/config.png" width="25" title="usage"> Usage example
```hcl
module "prepare_environment" {
  source               = "git@github.com:obervinov/tf-module-setup-server.git/?ref=release/v1.0.0"
  username             = var.username
  droplet_name         = "server-1"
  droplet_region       = "nyc1"
  droplet_image        = "ubuntu-22-10-x64"
  droplet_size         = "s-1vcpu-1gb"
  droplet_tags         = ["ssh", "ubuntu"]
  droplet_project_name = "project-1"
  digitalocean_token   = var.digitalocean_token
  public_key_name      = var.public_key_name
  domain_zone          = "example.com"
  domain_name          = "webui"
  droplet_dns_record   = true
  droplet_reserved_ip  = true
  packages_list        = ["python3", "libsecret-tools", "python3-pip"]
  remote_commands      = [
    "sudo mkdir -p /opt/data && sudo chmod -R 777 /opt/data",
    "sudo docker compose -f /opt/configs/docker-compose.yml up -d",
  ]
}

```


