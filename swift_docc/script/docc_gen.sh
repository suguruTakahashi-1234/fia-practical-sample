#!/bin/bash

package_name="DISampleAppPackage"
target_scheme="DomainLayer"
hosting_base_path="fia-practical-sample"
output_path="./docs"
github_pages_root_url="https://sugurutakahashi-1234.github.io/$hosting_base_path"

# TODO: 今は複数ターゲットを指定することができないので、それが可能になったらそのオプションを追加する
# Ref: https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/publishing-to-github-pages/#Generating-the-Documentation-Site
swift package --package-path "$package_name" --allow-writing-to-directory "$output_path" \
    generate-documentation --target "$target_scheme" \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path "$hosting_base_path" \
    --output-path "$output_path"

echo "Documentation for $target_scheme has been generated and saved to $output_path"

target_scheme_lower=$(echo "$target_scheme" | tr '[:upper:]' '[:lower:]')
url="$github_pages_root_url/documentation/$target_scheme_lower"
echo "After pushing your changes to GitHub, please visit the following url to view the documentation:"
echo "$url"
