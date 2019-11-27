# terraform_azure_sharedresource
Azure環境をデプロイするための共有設定

基本的にあまり解説はしませんが個人的にテストを行っているAzure環境構築用設定ファイルです。
著作権は作者が保有しますが転載、複製などは許可なくご自由にどうぞ

## 利用方法

[環境変数の設定](https://docs.microsoft.com/ja-jp/azure/virtual-machines/linux/terraform-install-configure?toc=https%3A%2F%2Fdocs.microsoft.com%2Fja-jp%2Fazure%2Fterraform%2Ftoc.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fja-jp%2Fazure%2Fbread%2Ftoc.json)
を参照して環境変数を設定

変数を以下の通り設定

|変数名|概要|省略値|
|---|---|---|
|`resource_group`|共有リソースを作成するリソースグループ名|(必須)|
|`location`|Azureのロケーション名|`japaneast`|
|`strage_diag_name`|共有リソースのストレージリソース名|(必須)|
|`keyvault_name`|共有リソースのkeyvaultリソース名|(必須)|
|`virtual_network`|バーチャルネットワーク名|(必須)|
|`private_dns_zone`|プライベートDNSのゾーン名|(必須)|
|`private_dns_link`|プライベートDNSリンク名|shardnetlink|
|`virtual_network_addressspace`|バーチャルネットワークのアドレススペース|["172.31.0.0/16"]|
|`virtual_network_subnets_length`|バーチャネルネットワーク内のサブネット長|24|
|`virtual_network_subnets_count`|バーチャルネットワーク内のサブネットカウント|[16]|
|`virtual_network_subnet_name`|パーちゃるネットワークのサブネット名（接頭語)|subnet|
|`tag_owner`|タグ情報(利用者)の内容|(必須)|
|`tag_application`|タグ情報(利用目的)の内容|(必須)|
|`tag_expiration`|タグ情報(利用期限)の内容|(必須)|


以下のコマンドを実行

```
terraform init
terraform plan 
terraform apply
terraform destroy
```


