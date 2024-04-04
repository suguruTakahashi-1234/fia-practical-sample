#!/bin/bash

# 引数の数の確認
if [ "$#" -ne 1 ]; then
    echo "Need args: $0 <Driver>"
    exit 1
fi

sourcery_package_path="./DISampleAppPackage"
driver_name="$1"
camel_case_driver_name=$(echo "$driver_name" | awk '{print tolower(substr($0, 1, 1)) substr($0, 2)}')
template_path="./sourcery/template"
source_dir="${sourcery_package_path}/Sources/Domain"

output_driver_dir="${source_dir}/Framework/Driver"
output_driver_protocol_dir="${source_dir}/Protocol/DriverProtocol"
output_driver_provider_dir="${source_dir}/Protocol/Provider"
output_driver_test_dir="${sourcery_package_path}/Tests/FrameworkTest/Driver"

current_user=$(whoami)
current_date=$(date "+%Y/%m/%d")

# --force-parse のオプションが拡張子を別にしないと効かないため、それを回避するためのワークアラウンド処理
remove_sourcery_header() {
    local target_directory="$1"
    # ファイルの先頭1行を読み込み、「// Generated using Sourcery」の文字列が含まれている場合、最初の3行を削除する
    find "$target_directory" -type f -name "*.swift" | while read -r file; do
        head=$(head -n 1 "$file")
        if echo "$head" | grep -q "// Generated using Sourcery"; then
            echo "Updating file: $file"
            tail -n +4 "$file" > "$file.tmp" && mv "$file.tmp" "$file"
        fi
    done
}

# 出力ディレクトリが存在しない場合は作成
mkdir -p "$output_driver_dir"
mkdir -p "$output_driver_protocol_dir"
mkdir -p "$output_driver_provider_dir"
mkdir -p "$output_driver_test_dir"

# Driver
swift run --package-path "$sourcery_package_path" mint run sourcery \
          --sources "$source_dir" \
          --templates "$template_path/Driver.stencil" \
          --output "$output_driver_dir/${driver_name}Driver.swift" \
          --args "driverName=$driver_name","userName=$current_user","date=$current_date"

remove_sourcery_header "$output_driver_dir"

# DriverProtocol
swift run --package-path "$sourcery_package_path" mint run sourcery \
          --sources "$source_dir" \
          --templates "$template_path/DriverProtocol.stencil" \
          --output "$output_driver_protocol_dir/${driver_name}DriverProtocol.swift" \
          --args "driverName=$driver_name","userName=$current_user","date=$current_date"

remove_sourcery_header "$output_driver_protocol_dir"

# DriverProvider
swift run --package-path "$sourcery_package_path" mint run sourcery \
          --sources "$source_dir" \
          --templates "$template_path/DriverProvider.stencil" \
          --output "$output_driver_provider_dir/${driver_name}DriverProvider.swift" \
          --args "driverName=$driver_name","camelCaseDriverName=$camel_case_driver_name","userName=$current_user","date=$current_date"

remove_sourcery_header "$output_driver_provider_dir"

# DriverTest
swift run --package-path "$sourcery_package_path" mint run sourcery \
          --sources "$source_dir" \
          --templates "$template_path/DriverTest.stencil" \
          --output "$output_driver_test_dir/${driver_name}DriverTest.swift" \
          --args "driverName=$driver_name","camelCaseDriverName=$camel_case_driver_name","userName=$current_user","date=$current_date"

remove_sourcery_header "$output_driver_test_dir"

echo "Sourcery DONE!!"
