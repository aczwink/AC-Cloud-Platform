terraform {
    backend "azurerm" {
        resource_group_name = "prd-rg-terraform-state"
        storage_account_name = "prdstactfstate"
        container_name = "terraform-state-acplatform"
        key = "terraform.tfstate"
    }
}