variable "location" {
    description = "Azure region for this environment"
    type = string

    validation {
        condition = contains(["francecentral", "westeurope"], var.location)
        error_message = "Region must be one of: westeurope."
    }
}