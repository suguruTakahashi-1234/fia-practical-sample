#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <Target> <Packge Name>"
    exit 1
fi

TARGET=$1
PACKAGE_NAME=$2

cd $PACKAGE_NAME

# TODO: 今は複数ターゲットを指定することができないので、それが可能になったらそのオプションを追加する
# Ref: https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/publishing-to-github-pages/#Generating-the-Documentation-Site
swift package --allow-writing-to-directory ../docs \
  generate-documentation --target "$TARGET" \
  --disable-indexing \
  --transform-for-static-hosting \
  --hosting-base-path DISample \
  --output-path ../docs

echo "Documentation for $TARGET has been generated and saved to ../docs"

TARGET_LOWER=$(echo "$1" | tr '[:upper:]' '[:lower:]')
URL="https://sugurutakahashi-1234.github.io/DISample/documentation/$TARGET_LOWER"
echo "After pushing your changes to GitHub, please visit the following URL to view the documentation:"
echo "$URL"
