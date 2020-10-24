terraform {
  required_version = ">= 0.13"
    backend "s3" {
      bucket = "benrowe-deploys"
      key = "terraform/states/laravel-aws-terraform/terraform.tfstate"
      region = "ap-southeast-2"
      profile = "aws-terraform-demo"
    }
  required_providers {
    aws = {
      source = "hashicorp/aws",
    }
  }
}
