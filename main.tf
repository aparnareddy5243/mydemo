provider "azurerm" {
  features {}
  version = "~> 2.0"
}

resource "azurerm_resource_group" "rg" {
  name     = "MyHTMLAppResourceGroup"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appservice" {
  name                = "myHTMLApp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
}
