
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name   = "ap_rg"
    storage_account_name  = "terraform5243"
    container_name        = "container5243"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "ap_rg"
  location = "west US"
}

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Correct SKU configuration using a block
  sku {
    tier = "Basic"  # B for Basic tier
    size = "B1"     # SKU size
  }

  # Specify the kind of app service plan, e.g., for Linux or Windows
  kind = "Linux"  # Use "Linux" or "Windows"
  reserved = true  # This must be set to true for Linux
}


resource "azurerm_Linux_web_app" "webapp" {
  name                = "Webapp524333"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_app_service_plan.appserviceplan.id
  http_only           = true

  site_config {
    dotnet_framework_version = "v4.0"
  }
}


