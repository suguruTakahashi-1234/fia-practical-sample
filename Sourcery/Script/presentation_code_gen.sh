#!/bin/bash

# 引数の数を確認
if [ "$#" -ne 1 ]; then
    echo "使用方法: $0 <ModuleName>"
    exit 1
fi

SOURCERY_PACKAGE_PATH="./DISampleAppPackage"
SCREEN_NAME="$1"
TEMPLATE_PATH="./Sourcery/Template"
SOURCE_DIR="${SOURCERY_PACKAGE_PATH}/Sources/Presentation"
OUTPUT_PRESENTATION_DIR="${SOURCE_DIR}/${SCREEN_NAME}"
OUTPUT_TEST_DIR="${SOURCERY_PACKAGE_PATH}/Tests/PreviewSnapshotTest"

# 出力ディレクトリが存在しない場合は作成
mkdir -p "$OUTPUT_PRESENTATION_DIR"

# 各コンポーネントを生成
for COMPONENT in "PresenterDependency" "Presenter" "Wireframe" "View"
do
    swift run --package-path "$SOURCERY_PACKAGE_PATH" mint run sourcery \
              --sources "$SOURCE_DIR" \
              --templates "$TEMPLATE_PATH/${COMPONENT}.stencil" \
              --output "$OUTPUT_PRESENTATION_DIR/${SCREEN_NAME}${COMPONENT}.swift" \
              --args "screenName=$SCREEN_NAME"
done

# 各コンポーネントを生成（テスト）
for COMPONENT in "ViewTest"
do
    swift run --package-path "$SOURCERY_PACKAGE_PATH" mint run sourcery \
                --sources "$SOURCE_DIR" \
                --templates "$TEMPLATE_PATH/${COMPONENT}.stencil" \
                --output "$OUTPUT_TEST_DIR/${SCREEN_NAME}${COMPONENT}.swift" \
                --args "screenName=$SCREEN_NAME"
done

echo "コンポーネントの生成が完了しました"
