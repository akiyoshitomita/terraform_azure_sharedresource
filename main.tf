

#　プロバイダの設定

provider "azurerm" {

}

# リソースグループ
resource "azurerm_resource_group" "rg" {
  name      = var.resource_group
  location  = var.location
  tags      = local.common_tags
}

# ストレージアカウント
resource "azurerm_storage_account" "diagstrage" {
  name                      = var.strage_diag_name
  resource_group_name       = var.resource_group
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "RAGRS"
  enable_https_traffic_only = true
  tags                      = local.common_tags
}

# 仮想ネットワーク
resource "azurerm_virtual_network" "virtualnet" {
  name                      = var.virtual_network
  address_space             = var.virtual_network_addressspace
  location                  = var.location
  resource_group_name       = var.resource_group
  tags                      = local.common_tags
}

# keyvault (共有設定情報を保存する場所)
resource "azurerm_key_vault" "mainvault" {
  name                = "tomitavault"
  location            = var.location
  resource_group_name = var.resource_group
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "get",
   ]

    secret_permissions = [
      "set",
      "get",
      "delete",
    ]
  }
  tags = local.common_tags
  lifecycle {
    ignore_changes = [ access_policy ]
  }
}

# ストレージアカウント名を保存
resource "azurerm_key_vault_secret" "configdiagname" {
  name         = "config-diagname"
  value        = var.strage_diag_name
  key_vault_id = azurerm_key_vault.mainvault.id
  tags = local.common_tags
  lifecycle {
    ignore_changes = [ value ]
  }
}




# ロケーション情報を保存
resource "azurerm_key_vault_secret" "configlocation" {
  name         = "config-location"
  value        = var.location
  key_vault_id = azurerm_key_vault.mainvault.id
  tags = local.common_tags
  lifecycle {
    ignore_changes = [ value ]
  }
}

# 利用者を保存
resource "azurerm_key_vault_secret" "configowner" {
  name         = "config-defaultowner"
  value        = var.tag_owner
  key_vault_id = azurerm_key_vault.mainvault.id
  tags = local.common_tags
  lifecycle {
    ignore_changes = [ value ]
  }
}
# 利用目的を保存
resource "azurerm_key_vault_secret" "configapplication" {
  name         = "config-defaultapplication"
  value        = var.tag_application
  key_vault_id = azurerm_key_vault.mainvault.id
  tags = local.common_tags
  lifecycle {
    ignore_changes = [ value ]
  }
}
# 利用目的を保存
resource "azurerm_key_vault_secret" "configexpiration" {
  name         = "config-defaultexpiration"
  value        = var.tag_expiration
  key_vault_id = azurerm_key_vault.mainvault.id
  tags = local.common_tags
  lifecycle {
    ignore_changes = [ value ]
  }
}


# デバッグ用
#output "currentclient" {
#  value = data.azurerm_client_config.current
#}
