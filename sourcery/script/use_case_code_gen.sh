#!/bin/bash

# 引数の数の確認
if [ "$#" -ne 1 ]; then
    echo "Need args: $0 <UseCase>"
    exit 1
fi

sourcery_package_path="./DISampleAppPackage"
use_case_name="$1"

echo $use_case_name
