terraform {
    backend "azurerm" {
        resource_group_name = "dev-rg-terraform-state"
        storage_account_name = "devstactfstate"
        container_name = "terraform-state-acplatform"
        key = "terraform.tfstate"
    }
}