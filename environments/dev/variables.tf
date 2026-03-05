variable "location" {
    description = "Azure region for this environment"
    type = string

    validation {
        condition = contains(["eastus2", "westeurope"], var.location)
        error_message = "Region must be one of: eastus2, westeurope."
    }
}