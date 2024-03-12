#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Root Path>"
    exit 1
fi

di_scheme="DependencyInjectorLayer"
root_path=$1
periphery_path="Periphery"
periphery_build_path="$periphery_path/build"
mint_package_path="DISampleAppPackage"

xcodebuild -scheme "${di_scheme}" -destination 'platform=iOS Simulator,OS=17.4,name=iPhone 15 Pro' -derivedDataPath "${periphery_build_path}" clean build

cd "${mint_package_path}"

swift run --package-path ../DISampleAppPackage mint run periphery scan \
    --skip-build \
    --index-store-path ../Periphery/build/Index.noindex/DataStore/ \
    --retain-swift-ui-previews \
    --retain-public \
    --targets "DomainLayer" "PresentationLayer" "DependencyInjectorLayer" "DeviceFramework" "FirebaseFramework" "LicenseFramework" \
    > ../Periphery/result.txt

# # 全てのSwift PackageターゲットをビルドPeripheryスキャンを実行する

# # constants＆functions定義
# root_path=$(dirname "$(dirname "$(realpath "$0")")")
# periphery_path="$root_path/Periphery"
# periphery_build_path="$periphery_path/build"
# build_platform='platform=iOS Simulator,OS=17.0,name=iPhone 14'
# SOURCERY_PACKAGE_PATH="./DISampleAppPackage"

# function join_array_to_string() {
#     local array=("$@")
#     local result=""
#     local delimiter=","

#     for item in "${array[@]}"; do
#         result+="$item$delimiter"
#     done

#     echo "${result%,}"
# }

# function run_periphery_scan() {
#     local package_path="$1"
#     local targets=$2
#     local package_result_path="$3"
    
#     # Package.swiftのディレクトリに移動する（Peripheryコマンドにパスを指定するオプションがないため）
#     cd "$package_path"
    
#     swift run --package-path "$root_path/DISampleAppPackage" \
#         mint run periphery scan --retain-public \
#                                 --retain-swift-ui-previews \
#                                 --skip-build \
#                                 --index-store-path "${periphery_build_path}/Index.noindex/DataStore/" \
#                                 --targets "$targets" --format xcode > "$package_result_path"
# }

# # 以下の issue のコメントのように scan の前にビルドする必要がある。また、EmomilBase で DI が行われているため、他のすべてのターゲットが従属しており、EmomilBase のビルドによって他のターゲットのビルドも可能となる。
# # Ref: Run periphery for iOS-specific Swift Package #281 https://github.com/peripheryapp/periphery/issues/281#issuecomment-1176244226
# xcodebuild -scheme DependencyInjectorLayer \
#             -destination "$build_platform" \
#             -derivedDataPath $periphery_build_path \
#             clean build

# # EmomilPackageスキャン
# emomil_package_result_path="$periphery_path/result.txt"
# emomil_targets=(
#     "CloudServiceFramework"
#     "DependencyInjectorLayer"
#     "Development"
#     "DevelopmentUITests"
#     "DeviceFramework"
#     "DomainLayer"
#     "DomainTest"
#     "FirebaseFramework"
#     "FrameworkTest"
#     "PresentationLayer"
#     "PresenterTest"
#     "PreviewCatalog"
#     "PreviewCatalogLayer"
#     "Production"
#     "ProductionUITests"
#     "ScenarioCatalog"
#     "ScenarioCatalogLayer"
#     "Staging"
#     "StagingUITests"
#     "ViewSnapshotTest"
# )
# run_periphery_scan "$root_path/DISampleAppPackage" \
#                     $(join_array_to_string "${emomil_targets[@]}") \
#                     $emomil_package_result_path

# # Clean up
# final_result_file="$periphery_path/result.txt"
# result_files=(
#     "$emomil_package_result_path"
#     "$emotion_analysis_package_result_path"
# )

# rm -f "$final_result_file"
# rm -rf "$periphery_build_path"

# for file in "${result_files[@]}"
# do
#     grep "$root_path" "$file" |
#     sed "s|${root_path}/||" >> "$final_result_file"
#     rm "$file"
# done


# echo "Periphery scanning completed!"
