terraform {
  required_version = "~> 0.12.0"

  required_providers {
    digitalocean = "~> 1.12"
  }

  backend "remote" {
    workspaces {
      prefix = "limesurvey-"
    }
    hostname     = "app.terraform.io"
    organization = "ye11ow-space"
  }
}