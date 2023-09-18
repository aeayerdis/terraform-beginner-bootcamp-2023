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

The bash script is located here: [./bin/install_terraform_cli.sh](./bin/install_terraform_cli)

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

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml  we need to point the script to a program to interpert it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks
