

#　プロバイダの設定
provider "azurerm" {
}

# リソースグループ
resource "azurerm_resource_group" "rg" {
  name      = var.resource_group
  location  = var.location
  tags      = local.common_tags
}

# --------------------------------------------------------------------
#  共通ストレージ設定
# --------------------------------------------------------------------

# ストレージアカウント
resource "azurerm_storage_account" "diagstrage" {
  name                      = var.strage_diag_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "RAGRS"
  enable_https_traffic_only = true
  tags                      = local.common_tags
}

# --------------------------------------------------------------------
#  共通ネットワーク設定
# --------------------------------------------------------------------

# 仮想ネットワーク
resource "azurerm_virtual_network" "virtualnet" {
  name                      = var.virtual_network
  address_space             = var.virtual_network_addressspace
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  tags                      = local.common_tags
}

# プライベートDNSゾーン
resource "azurerm_private_dns_zone" "dnszone" {
  name                      = var.private_dns_zone
  resource_group_name       = azurerm_resource_group.rg.name
  tags                      = local.common_tags
}

# プライベートDNSゾーンと仮想ネットワークのリンク
resource "azurerm_private_dns_zone_virtual_network_link" "dnslink" {
  name                      = var.private_dns_link
  resource_group_name       = azurerm_resource_group.rg.name
  private_dns_zone_name     = azurerm_private_dns_zone.dnszone.name
  virtual_network_id        = azurerm_virtual_network.virtualnet.id
  registration_enabled      = true  
  tags                      = local.common_tags
}  

# サブネットの計算
locals {
  vnet_len = [ for net in var.virtual_network_addressspace: tonumber(regex("/(\\d+)", net)[0]) ]
  subnets  = flatten( 
               [ for i in range(length(var.virtual_network_addressspace)): 
                 [ for j in range( var.viratul_network_subnets_count[i] ) :
                    cidrsubnet(var.virtual_network_addressspace[i], 
                               var.virtual_network_subnets_length - local.vnet_len[i], j) 
                 ]
               ])
}

# サブネット
resource "azurerm_subnet" "subnets" {
  count                     = length(local.subnets) 
  name                      = "${var.virtual_network_subnet_name}_${count.index}"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.virtualnet.name
  address_prefix            = local.subnets[count.index] 
}

# --------------------------------------------------------------------
#  共通設定情報の保存
# --------------------------------------------------------------------

# keyvault (共有設定情報を保存する場所)
resource "azurerm_key_vault" "mainvault" {
  name                = var.keyvault 
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "set",
      "get",
      "list",
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
  value        = azurerm_storage_account.diagstrage.name
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

# Vネット名を保存
resource "azurerm_key_vault_secret" "configvnet" {
  name         = "config-vnet"
  value        = azurerm_virtual_network.virtualnet.name
  key_vault_id = azurerm_key_vault.mainvault.id
  tags = local.common_tags
  lifecycle {
    ignore_changes = [ value ]
  }
}


# プライベートゾーン名を保存
resource "azurerm_key_vault_secret" "configpdnszone" {
  name         = "config-pdnszone"
  value        = azurerm_private_dns_zone.dnszone.name
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
