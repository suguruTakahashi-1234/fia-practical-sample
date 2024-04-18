#!/bin/bash

# 引数の数の確認
if [ "$#" -ne 2 ]; then
    echo "Need args: $0 <DI Container> <View>"
    exit 1
fi

sourcery_package_path="./DISampleAppPackage"
di_container_name="$1"
screen_name="$2"
template_path="./sourcery/template/presentation_code_gen"
source_dir="${sourcery_package_path}/Sources/Presentation"

output_presentation_dir="${source_dir}/View/${screen_name}"
output_di_container_dependency_dir="${source_dir}/DIContainerDependency"
output_test_dir="${sourcery_package_path}/Tests"

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
mkdir -p "$output_presentation_dir"
mkdir -p "$output_di_container_dependency_dir"
mkdir -p "$output_test_dir"

# View 関連
for component in "PresenterDependency" "Presenter" "View"
do
    swift run --package-path "$sourcery_package_path" mint run sourcery \
              --sources "$source_dir" \
              --templates "$template_path/${component}.stencil" \
              --output "$output_presentation_dir/${screen_name}${component}.swift" \
              --args "screenName=$screen_name","diContainerName=$di_container_name","userName=$current_user","date=$current_date"
done
remove_sourcery_header "$output_presentation_dir"

# DIContainer 関連
for component in "DIContainerDependency"
do
swift run --package-path "$sourcery_package_path" mint run sourcery --disableCache \
          --sources "$source_dir" \
          --templates "$template_path/${component}.stencil" \
          --output "$output_di_container_dependency_dir/${di_container_name}${component}.swift" \
          --args "screenName=$screen_name","diContainerName=$di_container_name","userName=$current_user","date=$current_date"
done
remove_sourcery_header "$output_di_container_dependency_dir"

# Test 関連
for component in "ViewSnapshotTest" "PresenterTest"
do
    swift run --package-path "$sourcery_package_path" mint run sourcery \
                --sources "$source_dir" \
                --templates "$template_path/${component}.stencil" \
                --output "$output_test_dir/${component}/${screen_name}${component}.swift" \
                --args "screenName=$screen_name","diContainerName=$di_container_name","userName=$current_user","date=$current_date"
done
remove_sourcery_header "$output_test_dir"

echo "Sourcery DONE!!"
