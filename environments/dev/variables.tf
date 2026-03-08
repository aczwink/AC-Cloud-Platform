variable "ai_location" {
    description = "Azure region for AI services"
    type = string
}

variable "location" {
    description = "Azure region for this environment"
    type = string

    validation {
        condition = contains(["eastus2", "westeurope"], var.location)
        error_message = "Region must be one of: eastus2, westeurope."
    }
}

variable "servicePrincipalObjectId" {
    description = "Object id of the Entra service principal that GitHub actions uses for CI/CD"
    type = string
}