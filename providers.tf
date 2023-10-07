terraform {
#   cloud {
#     organization = "aea"

#     workspaces {
#       name = "terra-house-soccer"
#     }
#   }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}