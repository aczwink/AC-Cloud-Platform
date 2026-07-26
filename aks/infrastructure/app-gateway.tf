locals {
    appGw_backendAddressPoolName = "default-backend-pool"
    appGw_httpListenerName = "http-listener"
}

resource "azurerm_application_gateway" "appGateway" {
    location = var.location
    name = "${local.environment}-agw-${local.appName}"
    resource_group_name = azurerm_resource_group.rg.name

    backend_address_pool {
        name = local.appGw_backendAddressPoolName
    }

    backend_http_settings {
        cookie_based_affinity = "Disabled"
        name = "http-settings"
        port = 80
        protocol = "Http"
    }

    frontend_ip_configuration {
        name = "frontend-ip-config"
        public_ip_address_id = azurerm_public_ip.pip.id
    }

    frontend_port {
        name = "HTTP-Port"
        port = 80
    }

    gateway_ip_configuration {
        name = "gateway-ip-config"
        subnet_id = azurerm_subnet.agwSubnet.id
    }

    http_listener {
        frontend_ip_configuration_name = "frontend-ip-config"
        frontend_port_name = "HTTP-Port"
        name = local.appGw_httpListenerName
        protocol = "Http"
    }

    request_routing_rule {
        backend_address_pool_name = local.appGw_backendAddressPoolName
        backend_http_settings_name = "http-settings"
        http_listener_name = local.appGw_httpListenerName
        name = "rule"
        priority = 100
        rule_type = "Basic"
    }

    sku {
        capacity = 1
        name = "Standard_v2"
        tier = "Standard_v2"
    }

    lifecycle {
      ignore_changes = [
        backend_address_pool,
        backend_http_settings,
        frontend_port,
        http_listener,
        probe,
        request_routing_rule,
        url_path_map
      ]
    }
}