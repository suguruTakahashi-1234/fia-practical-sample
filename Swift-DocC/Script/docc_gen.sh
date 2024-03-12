#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <Target> <Packge Name>"
    exit 1
fi

target=$1
package_name=$2

cd $package_name

# TODO: 今は複数ターゲットを指定することができないので、それが可能になったらそのオプションを追加する
# Ref: https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/publishing-to-github-pages/#Generating-the-Documentation-Site
swift package --allow-writing-to-directory ../docs \
    generate-documentation --target "$target" \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path DISample \
    --output-path ../docs

echo "Documentation for $target has been generated and saved to ../docs"

target_lower=$(echo "$1" | tr '[:upper:]' '[:lower:]')
url="https://sugurutakahashi-1234.github.io/DISample/documentation/$target_lower"
echo "After pushing your changes to GitHub, please visit the following url to view the documentation:"
echo "$url"
