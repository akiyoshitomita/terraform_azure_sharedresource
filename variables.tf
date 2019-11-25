
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
