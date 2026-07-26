resource "azurerm_kubernetes_cluster" "aks" {
  location            = var.location
  name                = "${local.environment}-aks-${local.appName}"
  resource_group_name = azurerm_resource_group.rg.name

  dns_prefix          = local.appName
  node_resource_group = "${local.environment}-rg-${local.appName}-AZUREMANAGED"
  oidc_issuer_enabled = true
  sku_tier            = "Free"

  default_node_pool {
    name = "default"

    node_count = 1
    temporary_name_for_rotation = "rotate"
    vm_size    = "Standard_B2als_v2"
    vnet_subnet_id = azurerm_subnet.aksSubnet.id

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  ingress_application_gateway {
    gateway_id = azurerm_application_gateway.appGateway.id
  }

  network_profile {
    dns_service_ip = "10.1.0.10"
    network_plugin = "azure"
    network_plugin_mode = "overlay"
    pod_cidr = "10.2.0.0/16"
    service_cidr = "10.1.0.0/16"
  }
}

/*
resource "azurerm_kubernetes_cluster_node_pool" "userNodePool" {
    name = "workloads"

    kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
    mode = "User"
    node_count = 3
    vm_size = "Standard_B2als_v2"

    upgrade_settings {
    }
}
*/

resource "azurerm_kubernetes_cluster_node_pool" "spotPool" {
  name = "spot"

  auto_scaling_enabled  = true
  eviction_policy       = "Delete"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  max_count             = 3
  min_count             = 0
  mode                  = "User"
  node_taints = [
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  ]
  priority       = "Spot"
  spot_max_price = -1
  vm_size        = "Standard_B2als_v2"
  vnet_subnet_id = azurerm_subnet.aksSubnet.id
}

//AGIC is the AKS+AGW extension and requires the following role assignments:
resource "azurerm_role_assignment" "agic_reader_rg" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Reader"
  principal_id         = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

resource "azurerm_role_assignment" "agic_contributor_appgw" {
  scope                = azurerm_application_gateway.appGateway.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}

resource "azurerm_role_assignment" "agic_network_contributor_subnet" {
  scope = azurerm_subnet.agwSubnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
}