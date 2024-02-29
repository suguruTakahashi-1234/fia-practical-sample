#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Target>"
    exit 1
fi

TARGET=$1

cd ./DISampleAppPackage

# Ref: https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/publishing-to-github-pages/#Generating-the-Documentation-Site
swift package --allow-writing-to-directory ../docs \
  generate-documentation --target "$TARGET" \
  --disable-indexing \
  --transform-for-static-hosting \
  --hosting-base-path "https://github.com/suguruTakahashi-1234/DISample/docs" \
  --output-path ../docs

echo "Documentation for $TARGET has been generated and saved to ../docs"

TARGET_LOWER=$(echo "$1" | tr '[:upper:]' '[:lower:]')
URL="https://sugurutakahashi-1234.github.io/DISample/documentation/$TARGET_LOWER"
echo $URL
open $URL