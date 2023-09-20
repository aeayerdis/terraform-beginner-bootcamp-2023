# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to use Semantic Versioning for its tagging.
[semserv.org](https://semver.org/)

The general format:
 **MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes


## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation guide has changed from the original instructions in the gitpod.yml file due to changes in gpg keyring deprecation. Needed to refer to the lastest Terraform documentation and change the scripting for installation.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/

### Considerations for checking Linux Distribution
This project is built using the Ubuntu Linux OS. You will need to check your variation of Linux and consider the steps to follow per your needs.

[How to check Linux OS Distribution](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version

```sh
$ cat /etc/os-release 
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts
While fixing the Terraform CLI gpg deprecation issues, created a new Terraform CLI installation bash script. This minimized the commands used in the gitpod.yml file to just run the script for installing the Terraform CLI.

The bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the ([.gitpod.yml](.gitpod.yml)) file tidy
- This will allow us an easier way to debug installation of Terraform CLI
- Will also allow better portability for other projects that may require Terraform CLI

#### Shebang Considerations

A shebang (pronounded Sha-Bang) tells the bash script what program will interpret the script. e.g. `#! /bin/bash`


[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

ChatGPT recommended this format for bash:`#! /usr/bin/env bash`
- for portability for different OS distros
- will search the user's `PATH` for bash executable

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notiation to execute the bash script.

eg. `./bin/install_terraform _cli`

If we are using a script in .gitpod.yml  we need to point the script to a program to interpert it.

eg. `source ./bin/install_terraform _cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod u+x ./bin/install_terraform _cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform _cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


### Working Env Vars

We can list out all Environment Variables (Env Vars) using the `env` command

We can filter specific  env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world'`

In the terminal we unset using `unset $HELLO`

We can set an env var termporarily when just running a command
```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export eg.
```sh
#! /usr/bin/env bash

HELLO ='world'

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

Wehn you open a new bash terminal in VSCode it will not be aware of env vars that you have set in another window.

If you want Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars in gitpod by storing them in Gitpod Secrets Storage

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting Started with AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following command:
```sh
aws sts get-caller-identity
```

If it is successful, the returned JSON payload should look like this:
```json
{
    "UserId": "AIDEXAMPLE",
    "Account": "123456789",
    "Arn": "arn:aws:iam::123456789:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials for a user that is NOT root in IAM


## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in Terraform .
- **Modules** are a way to make large amount of Terraform code modular, portable and sharable.

[Randon Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terrform commands by simply typing `terraform`


#### Terraform Init

At the start of a new Terraform project, run `terraform init` to download the binaries for the Terraform providers that are used in this project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be execute by Terraform . Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`teraform destroy`
This will destroy resources.

You can also use the `--auto-approve` flag to skip the approve prompt eg. 

`terraform apply --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of the infrastructure.

This file **should not be commited** to your VCS.

This file can contain sensentive data.

If you lose this file, you lose knowning the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of Terraform providers.