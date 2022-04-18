terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "3.3.0"
    }
  }
}

#provider "aws" {
#  region = "eu-west-3"
#  profile = "start"
#}
#
#provider "aws" {
#  alias   = "shared"
#  region = "eu-west-3"
#}

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
#  key_name   = "${var.project}_${var.environment}_deployer-key"
#  public_key = tls_private_key.this.public_key_openssh
#}