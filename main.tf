
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
  location = "East US"
}

resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "webapp5243plan"
  location            = "East US"
  resource_group_name = "ap_rg"

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "webapp" {
  name                = "Webapp5243"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  site_config {
    dotnet_framework_version = "v4.0"
  }
}