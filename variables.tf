
variable "resource_group" {
  description = "リソースグループ名"
  type        = string
}

variable "location" {
  description = "Azureのロケーション名"
  type        = string
  default     = "japaneast"
}

variable "strage_diag_name"{
  description = "ダイアグ情報を保存するための共通ストレージアカウント名"
  type        = string
}

variable "tag_owner" {
  description = "利用者"
  type        = string
}

variable "tag_application" {
  description = "利用目的"
  type        = string
  default     = "テスト利用"
}

variable "tag_expiration" {
  description = "利用期日"
  type        = string
}

variable "virtual_network" {
  description = "仮想ネットワークの名"
  type        = string
}

variable "private_dns_zone" {
  description = "プライベートDNSのドメイン名"
  type        = string
}

variable "private_dns_link" {
  description = "プライベートDNSのリンク名"
  type        = string
  default     = "sharednetlink"
}


variable "virtual_network_addressspace" {
  description = "仮想ネットワークのアドレスレンジ"
  type        = list(string)
  default     = ["172.31.0.0/16"]
}

variable "virtual_network_subnets_length" {
  description = "仮想ネットワークのサブネットのマスク長"
  type        = number 
  default     = 24
}

variable "viratul_network_subnets_count" {
  description = "仮想ネットワークのサブネットの数"
  type        = list(number)
  default     = [16]
}

variable "virtual_network_subnet_name" {
  description = "仮想ネットワークのサブネット名の接頭語"
  type        = string
  default     = "subnet"
}

variable "keyvault" {
  description = "設定情報を入れるためのキーコンテナの名前"
  type        = string
}
