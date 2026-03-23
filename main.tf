terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.65.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "08b7b8d4-af42-4972-9517-11ea256ea068"
}

resource "azurerm_resource_group" "rg" { 
   name     = "rg-sql" 
   location = "australiacentral" 
 } 
  
 resource "azurerm_mssql_server" "sql_server" { 
   name                         = "sqlserver2024-${random_id.server_suffix.hex}" 
    resource_group_name          = azurerm_resource_group.rg.name 
   location                     = azurerm_resource_group.rg.location 
   version                      = "12.0" 
   administrator_login          = "sqladmin" 
   administrator_login_password = "P@ssw0rd1234" 
 } 
   
 resource "random_id" "server_suffix" { 
   byte_length = 2 
 } 
  
  
 resource "azurerm_mssql_database" "sql_database" { 
   name      = "sqldatabase2024" 
   server_id = azurerm_mssql_server.sql_server.id 
   sku_name  = "Basic" 
 }
