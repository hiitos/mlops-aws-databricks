#!/bin/bash

# AWS CLIがインストールされていることを確認
if ! command -v aws &> /dev/null
then
    echo "AWS CLI could not be found. Please install it and try again."
    exit 1
fi

# ../terraform/terraform.tfvarsファイルの存在を確認
TFVARS_FILE="../terraform/terraform.tfvars"

if [ ! -f "$TFVARS_FILE" ]; then
    echo "$TFVARS_FILE file not found!"
    exit 1
fi

# ../terraform/terraform.tfvarsファイルを読み込んでSSMパラメータストアに登録
while IFS= read -r line; do
    # 空行とコメントを無視
    if [[ -z "$line" || "$line" == \#* ]]; then
        continue
    fi

    # 変数名と値を取得
    var_name=$(echo "$line" | cut -d '=' -f 1 | xargs)
    var_value=$(echo "$line" | cut -d '=' -f 2 | xargs | sed 's/"//g')

    # SSMパラメータストアに登録（出力を無視）
    aws ssm put-parameter --name "$var_name" --value "$var_value" --type "String" --overwrite >/dev/null 2>&1

    echo "Registered $var_name with value $var_value to SSM Parameter Store"
done < "$TFVARS_FILE"
