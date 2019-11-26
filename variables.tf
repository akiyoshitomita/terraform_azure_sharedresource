
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

variable "virtual_network_addressspace" {
  description = "仮想ネットワークのアドレスレンジ"
  type        = list(string)
  default     = ["172.31.0.0/16"]
}

variable "virtual_network_subnets" {
  description = "仮想ネットワークのサブネット"
  type        = list(string)
  default     = [
                   "172.31.0.0/24", 
                   "172.31.1.0/24", 
                   "172.31.2.0/24", 
                   "172.31.3.0/24", 
                   "172.31.4.0/24", 
                   "172.31.5.0/24", 
                   "172.31.6.0/24", 
                   "172.31.7.0/24", 
                   "172.31.8.0/24", 
                   "172.31.9.0/24", 
                   "172.31.10.0/24", 
                   "172.31.11.0/24", 
                   "172.31.12.0/24", 
                   "172.31.13.0/24", 
                   "172.31.14.0/24", 
                   "172.31.15.0/24", 
               ]
}
