terraform {
  # REQUIRED PROVIDERS
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.10.0"
    }
    time = {
      source = "hashicorp/time"
      version = "0.7.2"
    }
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
    tls = {
      source = "hashicorp/tls"
      version = "3.3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
  profile = "start"
}

provider "aws" {
  alias   = "shared"
  region = "eu-west-3"
}

# -----
provider "tls" {}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

locals {
  extract_chaine = split("\n", tls_private_key.this.private_key_pem)
  chaine         = slice(local.extract_chaine, 1, length(local.extract_chaine) - 2)
  key            = join("", [for s in local.chaine : format("%s", s)])
}

#resource "aws_key_pair" "deployer" {
#  key_name   = "deployer-key"
#  public_key = module.defaultKeys.public_key
#}