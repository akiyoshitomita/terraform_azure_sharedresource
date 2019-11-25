# Azure環境 共有リソース定義

本リソースはVPN先の共有ネットワークやアカウント情報ログの保存ストレージなど共有するリソースを定義するためのものです。


# 利用方法

1. `terraform.tfvars` ファイルを編集
2. 以下のコマンドを実行

```
$ terraform init
$ terraform plan
$ terraform apply
```


## varsの解説

`resource_group`: リソースグループ名の定義

`location`: ロケーション名を指定（省略時: japaneast)

`tag_owner`: 利用者名(タグに追加)
`tag_application`: 利用目的を完結に記載(タグに追加)
`tag_expiration`: 利用記述を記載(タグに追加)
