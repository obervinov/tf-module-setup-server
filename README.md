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
This module performs the initial creation of a server in digitalocean, as well as performs basic preparation of the environment: creating users, installing packages, configuring sshd and etc.

## <img src="https://github.com/obervinov/_templates/blob/main/icons/stack.png" width="25" title="stack"> Repository map
```sh
.
├── CHANGELOG.md
├── LICENSE
├── README.md
├── SECURITY.md
├── ansible
│   ├── playbook.yml
│   └── roles
│       ├── config_sshd
│       │   ├── default
│       │   │   └── main.yml
│       │   ├── meta
│       │   │   └── main.yml
│       │   ├── tasks
│       │   │   └── main.yml
│       │   └── templates
│       │       └── sshd_config.j2
│       ├── create_user
│       │   ├── default
│       │   │   └── main.yml
│       │   ├── meta
│       │   │   └── main.yml
│       │   └── tasks
│       │       └── main.yml
│       └── install_packages
│           ├── defaults
│           │   └── main.yml
│           ├── meta
│           │   └── main.yml
│           └── tasks
│               └── main.yml
├── data.tf
├── main.tf
├── output.tf
├── providers.tf
└── variables.tf
```

## <img src="https://github.com/obervinov/_templates/blob/main/icons/requirements.png" width="25" title="requirements"> Requirements
| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | 2.28.1 |

## <img src="https://github.com/obervinov/_templates/blob/main/icons/file.png" width="18" title="porviders"> Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.28.1 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## <img src="https://github.com/obervinov/_templates/blob/main/icons/config.png" width="25" title="resources">  Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.droplet](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/resources/droplet) | resource |
| [digitalocean_project_resources.project_resources](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/resources/project_resources) | resource |
| [null_resource.ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [digitalocean_project.project](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/data-sources/project) | data source |
| [digitalocean_ssh_key.ssh_key](https://registry.terraform.io/providers/digitalocean/digitalocean/2.28.1/docs/data-sources/ssh_key) | data source |

## <img src="https://github.com/obervinov/_templates/blob/main/icons/build.png" width="25" title="inputs"> Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_playbook"></a> [ansible\_playbook](#input\_ansible\_playbook) | The path to the playbook Ansible file | `string` | `"ansible/playbook.yml"` | no |
| <a name="input_digitalocean_token"></a> [digitalocean\_token](#input\_digitalocean\_token) | DigitalOcean API Token | `string` | n/a | yes |
| <a name="input_droplet_image"></a> [droplet\_image](#input\_droplet\_image) | The image of the droplet | `string` | `""` | no |
| <a name="input_droplet_name"></a> [droplet\_name](#input\_droplet\_name) | The name of the droplet | `string` | `""` | no |
| <a name="input_droplet_project_name"></a> [droplet\_project\_name](#input\_droplet\_project\_name) | The target project for the droplet | `string` | n/a | yes |
| <a name="input_droplet_region"></a> [droplet\_region](#input\_droplet\_region) | The region of the droplet | `string` | `""` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | The size of the droplet | `string` | n/a | yes |
| <a name="input_droplet_tags"></a> [droplet\_tags](#input\_droplet\_tags) | The tags of the droplet | `list` | n/a | yes |
| <a name="input_packages_list"></a> [packages\_list](#input\_packages\_list) | List of packages to install | `list(string)` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Password for username | `string` | n/a | yes |
| <a name="input_public_key_name"></a> [public\_key\_name](#input\_public\_key\_name) | Name of the public key in digital ocean | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username | `string` | n/a | yes |

## <img src="https://github.com/obervinov/_templates/blob/main/icons/stack2.png" width="25" title="outputs"> Outputs

| Name | Description |
|------|-------------|
| <a name="output_droplet"></a> [droplet](#output\_droplet) | Droplet Name |
| <a name="output_sshkey"></a> [sshkey](#output\_sshkey) | SSH Key fingerprint |
| <a name="output_username"></a> [username](#output\_username) | New user username |

## <img src="https://github.com/obervinov/_templates/blob/main/icons/config.png" width="25" title="usage"> Usage example
```hcl
module "prepare_environment" {
  source               = "git@github.com:obervinov/tf-module-setup-server.git/?ref=v1.0.0"
  username             = var.username
  password             = var.password
  droplet_name         = "droplet1"
  droplet_region       = "ams3"
  droplet_image        = "ubuntu-22-10-x64"
  droplet_size         = "s-1vcpu-512mb-10gb"
  droplet_tags         = ["ubuntu", "nginx"]
  droplet_project_name = "project1"
  ansible_playbook     = "./ansible/playbook.yml"
  digitalocean_token   = var.digitalocean_token
  public_key_name      = var.public_key_name
  packages_list        = ["htop", "python3", "net-tools", "curl", "git", "vim", "ca-certificates", "gnupg", "docker-ce"]
}
```
