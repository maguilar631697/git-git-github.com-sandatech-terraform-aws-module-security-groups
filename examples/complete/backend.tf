

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

/*
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "sandata-tech"
    
    workspaces {
      name = "sandata-rd-us-east-1-rds-mysql-smc-01"
    }
  }
}

*/

