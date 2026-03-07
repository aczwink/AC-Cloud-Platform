variable "location" {
    description = "Azure region for this environment"
    type = string

    validation {
        condition = contains(["westeurope"], var.location)
        error_message = "Region must be one of: westeurope."
    }
}

variable "servicePrincipalObjectId" {
    description = "Object id of the Entra service principal that GitHub actions uses for CI/CD"
    type = string
}