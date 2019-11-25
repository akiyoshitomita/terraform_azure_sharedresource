

#　プロバイダの設定

provider "azurerm" {

}

# リソースグループ
resource "azurerm_resource_group" "rg" {
  name      = var.resource_group
  location  = var.location
  tags = local.common_tags
}

# ストレージアカウント
resource "azurerm_storage_account" "diagstrage" {
  name                      = var.strage_diag_name
  resource_group_name       = var.resource_group
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "RAGRS"
  enable_https_traffic_only = true
  tags = local.common_tags
}

# keyvault (共有設定情報を保存する場所)
resource "azurerm_key_vault" "mainvault" {
  name                = "tomitavault"
  location            = var.location
  resource_group_name = var.resource_group
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  tags = local.common_tags
}
