#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Target>"
    exit 1
fi

TARGET=$1

cd ./DISampleAppPackage

# Ref: https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/publishing-to-github-pages/#Generating-the-Documentation-Site
swift package --allow-writing-to-directory ../Swift-DocC/docs \
  generate-documentation --target "$TARGET" \
  --disable-indexing \
  --transform-for-static-hosting \
  --hosting-base-path "https://github.com/suguruTakahashi-1234/DISample" \
  --output-path ../Swift-DocC/docs

# スクリプトの実行が完了したことを示すメッセージを表示します。
echo "Documentation for $TARGET has been generated and saved to ../Swift-DocC/docs"
