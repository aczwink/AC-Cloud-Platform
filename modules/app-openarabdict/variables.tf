variable "ai_location" {
    description = "Azure region for AI services"
    type = string
}

variable "appServicePlanId" {
    description = "Linux App Service Plan Id"
    type = string
}

variable "buildId" {
    description = "Id of the build of Azure functions"
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

variable "funcServicePlanId" {
    description = "Function Service Plan Id"
    type = string
}

variable "gptModelDeploymentName" {
    description = "Model deployment name of the OpenAI GPT model"
    type = string
}

variable "location" {
    description = "Azure region"
    type = string
}

variable "logAnalyticsWorkspaceId" {
    description = "Log Analytics Workspace Id"
    type = string
}

variable "openAIServiceKey" {
    description = "Service key of the OpenAI service"
    type = string
    sensitive = true
}

variable "servicePrincipalObjectId" {
    description = "Object id of the Entra service principal that writes the database files"
    type = string
}

variable "translationServiceKey" {
    description = "Service key of the Translator service"
    type = string
    sensitive = true
}