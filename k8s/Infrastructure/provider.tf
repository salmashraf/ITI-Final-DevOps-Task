/* terraform {
 required_providers {
  aws = {
   source = "hashicorp/aws"
  }
 }
} */ 


provider "aws" {
  region = var.region
  shared_config_files = var.config
  shared_credentials_files = var.credentials
  profile = "dev-user"
}