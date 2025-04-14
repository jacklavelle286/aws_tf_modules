terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "s3" {
    bucket         = "438465154544-eu-west-2-backend-infra-tf-bootstrap-modules"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "438465154544-eu-west-2-backend-infra-tf-bootstrap-modules-lock"
  }


}



provider "aws" {
  region = var.region

}

