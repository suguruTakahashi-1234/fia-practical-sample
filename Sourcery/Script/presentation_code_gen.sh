#!/bin/bash

# 引数の数の確認
if [ "$#" -ne 2 ]; then
    echo "Need args: $0 <VIEW=XXX> <ROUTER=YYY>"
    exit 1
fi

SOURCERY_PACKAGE_PATH="./DISampleAppPackage"
SCREEN_NAME="$1"
ROUTER_NAME="$2"
TEMPLATE_PATH="./Sourcery/Template"
SOURCE_DIR="${SOURCERY_PACKAGE_PATH}/Sources/Presentation"
OUTPUT_PRESENTATION_DIR="${SOURCE_DIR}/${SCREEN_NAME}"
OUTPUT_ROUTER_DIR="${SOURCE_DIR}/${ROUTER_NAME}"
OUTPUT_TEST_DIR="${SOURCERY_PACKAGE_PATH}/Tests/PreviewSnapshotTest"

# 出力ディレクトリが存在しない場合は作成
mkdir -p "$OUTPUT_PRESENTATION_DIR"
mkdir -p "$OUTPUT_ROUTER_DIR"
mkdir -p "$OUTPUT_TEST_DIR"

# View 関連
for COMPONENT in "PresenterDependency" "Presenter" "Wireframe" "View"
do
    swift run --package-path "$SOURCERY_PACKAGE_PATH" mint run sourcery \
              --sources "$SOURCE_DIR" \
              --templates "$TEMPLATE_PATH/${COMPONENT}.stencil" \
              --output "$OUTPUT_PRESENTATION_DIR/${SCREEN_NAME}${COMPONENT}.swift" \
              --args "screenName=$SCREEN_NAME",routerName="$ROUTER_NAME"
done

# --force-parse のオプションが拡張子を別にしないと効かないため、それを回避するためのワークアラウンド処理
find "$OUTPUT_PRESENTATION_DIR" -type f -name "*.swift" | while read -r file; do
    # ファイルの先頭1行を読み込み、「// Generated using Sourcery」の文字列が含まれている場合、最初の3行を削除する
    head=$(head -n 1 "$file")
    if echo "$head" | grep -q "// Generated using Sourcery"; then
        echo "Updating file: $file"
        tail -n +4 "$file" > "$file.tmp" && mv "$file.tmp" "$file"
    fi
done

# Router 関連
for COMPONENT in "RouterDependency"
do
swift run --package-path "$SOURCERY_PACKAGE_PATH" mint run sourcery --disableCache \
          --sources "$SOURCE_DIR" \
          --templates "$TEMPLATE_PATH/${COMPONENT}.stencil" \
          --output "$OUTPUT_ROUTER_DIR/${ROUTER_NAME}${COMPONENT}.swift" \
          --args screenName="$SCREEN_NAME",routerName="$ROUTER_NAME"
done

# Test 関連
for COMPONENT in "ViewTest"
do
    swift run --package-path "$SOURCERY_PACKAGE_PATH" mint run sourcery \
                --sources "$SOURCE_DIR" \
                --templates "$TEMPLATE_PATH/${COMPONENT}.stencil" \
                --output "$OUTPUT_TEST_DIR/${SCREEN_NAME}${COMPONENT}.swift" \
                --args "screenName=$SCREEN_NAME",routerName="$ROUTER_NAME"
done

echo "Sourcery DONE!!"
