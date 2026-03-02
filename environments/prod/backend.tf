terraform {
    backend "azurerm" {
        resource_group_name = "${local.env}-rg-terraform-state"
        storage_account_name = "${local.env}sttfstate"
        container_name = "terraform-state-acplatform"
        key = "terraform.tfstate"
    }
}