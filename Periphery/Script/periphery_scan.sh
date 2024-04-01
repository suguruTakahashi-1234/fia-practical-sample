#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Root Path>"
    exit 1
fi

di_scheme="DependencyInjectionLayer"
root_path=$1
periphery_path="$root_path/periphery"
periphery_build_path="$periphery_path/build"
output_file="$periphery_path/result.txt"
index_store_path="$periphery_build_path/Index.noindex/DataStore/"
mint_package_path="$root_path/DISampleAppPackage"

# periphery_build_path が存在する場合、削除する（速度的には遅くなるがschemeを増やしたときに periphery が失敗して、原因究明に時間がかかるので毎回削除するようにしている）
rm -rf "$periphery_build_path"

# periphery を実行すると MacOS でビルドを行うが、アプリ内部で UIKit など、iOS 依存なコードがあるとビルドできないため、一旦 xcodebuild コマンドでプラットフォームを指定して、ビルドする必要がある
# 失敗する場合は periphery/build ディレクトリを削除してから、また、make コマンドを実行してください
xcodebuild -scheme $di_scheme -destination 'platform=iOS Simulator,OS=17.4,name=iPhone 15 Pro' -derivedDataPath $periphery_build_path clean build

# periphery の仕様なのか、ディレクトリを移動しないと SwiftPM マルチモジュール かつ Workspace で構成されるプロジェクト対応できない
cd "${mint_package_path}"

# Swift パッケージを指定したパスで実行し、periphery を使用してプロジェクトをスキャン
# --skip-build: ビルドプロセスをスキップ
# --index-store-path: ビルドプロセスをスキップしたので、xcodebuild でビルドしたindex-store-pathの指定
# --retain-swift-ui-previews: SwiftUI のプレビューはそのままにしておく
# --retain-public: 不要な Public 宣言はそのままにしておく
swift run --package-path $mint_package_path mint run periphery scan \
    --skip-build --index-store-path $index_store_path \
    --retain-swift-ui-previews \
    --retain-public \
    --targets "DomainLayer" "PresentationLayer" "DependencyInjectionLayer" "DeviceFramework" "FirebaseFramework" "LicenseFramework" \
    > $output_file

# 出力に環境依存な root_path が付与されるため、それを削除する
sed "s|${root_path}/||g" $output_file > temp_file && mv temp_file $output_file

echo "Periphery Scan Completed!!!!"
