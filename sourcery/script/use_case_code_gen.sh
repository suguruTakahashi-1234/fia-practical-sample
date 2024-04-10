#!/bin/bash

# 引数の数の確認
if [ "$#" -ne 2 ]; then
    echo "Need args: $0 <Router> <UseCase>"
    exit 1
fi

sourcery_package_path="./DISampleAppPackage"
router_name="$1"
use_case_name="$2"
template_path="./sourcery/template/use_case_code_gen"
source_dir="${sourcery_package_path}/Sources"

output_use_case_dir="${source_dir}/Domain/Protocol/UseCase"
output_interactor_dependency_dir="${source_dir}/Presentation/Interactor"
output_interactor_dir="${source_dir}/Presentation/Interactor"
output_interactor_test_dir="${sourcery_package_path}/Tests/InteractorTest"

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
mkdir -p "$output_use_case_dir"
mkdir -p "$output_interactor_dependency_dir"
mkdir -p "$output_interactor_dir"
mkdir -p "$output_interactor_test_dir"

# UseCase
swift run --package-path "$sourcery_package_path" mint run sourcery \
          --sources "$source_dir" \
          --templates "$template_path/UseCase.stencil" \
          --output "$output_use_case_dir/${use_case_name}UseCase.swift" \
          --args "useCaseName=$use_case_name","userName=$current_user","date=$current_date"

remove_sourcery_header "$output_use_case_dir"

# InteractorDependency
swift run --package-path "$sourcery_package_path" mint run sourcery \
          --sources "$source_dir" \
          --templates "$template_path/InteractorDependency.stencil" \
          --output "$output_interactor_dependency_dir/${use_case_name}InteractorDependency.swift" \
          --args "useCaseName=$use_case_name","userName=$current_user","date=$current_date"

remove_sourcery_header "$output_interactor_dependency_dir"

# Interactor
swift run --package-path "$sourcery_package_path" mint run sourcery \
          --sources "$source_dir" \
          --templates "$template_path/Interactor.stencil" \
          --output "$output_interactor_dir/${use_case_name}Interactor.swift" \
          --args "useCaseName=$use_case_name","userName=$current_user","date=$current_date"

remove_sourcery_header "$output_interactor_dir"

# InteractorTest
swift run --package-path "$sourcery_package_path" mint run sourcery \
          --sources "$source_dir" \
          --templates "$template_path/InteractorTest.stencil" \
          --output "$output_interactor_test_dir/${use_case_name}InteractorTest.swift" \
          --args "useCaseName=$use_case_name","routerName=$router_name","userName=$current_user","date=$current_date"

remove_sourcery_header "$output_interactor_test_dir"

echo "Sourcery DONE!!"
