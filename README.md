# terraform_azure_sharedresource
Azure環境をデプロイするための共有設定

基本的にあまり解説はしませんが個人的にテストを行っているAzure環境構築用設定ファイルです。
著作権は作者が保有しますが転載、複製などは許可なくご自由にどうぞ

## 利用方法

[環境変数の設定](https://docs.microsoft.com/ja-jp/azure/virtual-machines/linux/terraform-install-configure?toc=https%3A%2F%2Fdocs.microsoft.com%2Fja-jp%2Fazure%2Fterraform%2Ftoc.json&bc=https%3A%2F%2Fdocs.microsoft.com%2Fja-jp%2Fazure%2Fbread%2Ftoc.json)
を参照して環境変数を設定


{resource_group: リソースグループ名の定義

location: ロケーション名を指定（省略時: japaneast)

tag_owner: 利用者名(タグに追加) tag_application: 利用目的を完結に記載(タグに追加) tag_expiration: 利用記述を記載(タグに追加)

以下のコマンドを実行

```
terraform init
terraform plan 
terraform apply
terraform destroy
```


