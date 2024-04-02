#!/bin/bash

tools_package="./DISampleAppPackage"
mermaid_output_path="./asset/mermaid"
image_output_path="./asset/image"

generate_diagram() {
    local input_options=$1
    local output_base=$2 # ファイル名の基本部分を保持する変数
    local output_file_mmd="$mermaid_output_path/${output_base}.mmd" # .mmd ファイルのフルパス
    local output_file_svg="$image_output_path/${output_base}.svg" # .svg ファイルのフルパス

    # Swift Package Plugin を使って mermaid ファイルを生成
    swift package --package-path $tools_package plugin depermaid $input_options > "$output_file_mmd"

    # 最初の1行と最後の2行を削除
    sed -i '' '1d' "$output_file_mmd"
    sed -i '' '$d' "$output_file_mmd"
    sed -i '' '$d' "$output_file_mmd"

    # Mermaid CLI を使って SVG 画像を生成
    npx @mermaid-js/mermaid-cli -i "$output_file_mmd" -o "$output_file_svg"
}

generate_diagram "--direction TD" "my_targets"
generate_diagram "--direction TD --test" "test_targets"
generate_diagram "--direction TD --product" "library_targets"
generate_diagram "--direction TD --test --product" "all_targets"
