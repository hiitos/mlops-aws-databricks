#!/bin/bash

# 取得するパラメータのプレフィックス
PREFIX="terraform"

# パラメータ名のリストを取得
PARAMETER_NAMES=$(aws ssm describe-parameters --query "Parameters[?starts_with(Name, '$PREFIX')].Name" --output text)

# パラメータを一度に取得し、環境変数として設定
aws ssm get-parameters --names $PARAMETER_NAMES --query "Parameters[*].{Name:Name,Value:Value}" --output json | jq -r '.[] | "export TF_VAR_\(.Name | sub("'"$PREFIX"'";""))=\(.Value)"' > set_env_vars.sh

# 環境変数として設定
source set_env_vars.sh

# 確認用
echo "Environment variables set:"
env | grep TF_VAR_
