variable "appServicePlanId" {
    description = "Linux App Service Plan Id"
    type = string
}

variable "environment" {
    description = "Environment name"
    type = string
    
    validation {
        condition = contains(["dev", "prd"], var.environment)
        error_message = "Environment must be one of: dev, prd."
    }
}

variable "location" {
    description = "Azure region"
    type = string
}