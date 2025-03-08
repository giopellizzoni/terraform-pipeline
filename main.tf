terraform {
  required_version = ">=1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.90.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.22.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-remote-state"
    storage_account_name = "giopelltfstate"
    container_name       = "gptfremotestate"
    key                  = "pipeline-github/terraform.tfstate"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-2"

  default_tags {
    tags = {
      owner      = "giopellizzoni"
      managed_by = "terraform"
    }
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "giopellizzoni-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-remote-state"
    storage_account_name = "giopelltfstate"
    container_name       = "gptfremotestate"
    key                  = "azure-vnet/terraform.tfstate"
  }
}
