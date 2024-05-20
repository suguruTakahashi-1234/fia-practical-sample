#!/bin/sh

# 以下の処理によって、TestFlight での Staging 環境のリリースページに、直近のタグからの PR のマージログを表示するようにしている
# Ref: https://developer.apple.com/documentation/xcode/including-notes-for-testers-with-a-beta-release-of-your-app
if [[ -d "$CI_APP_STORE_SIGNED_APP_PATH" ]] && [[ "$CI_WORKFLOW" == "Distribute Staging App to TestFlight by PR Merged" ]]; then
    TESTFLIGHT_DIR_PATH=../TestFlight
    echo "Creating directory: $TESTFLIGHT_DIR_PATH"
    mkdir -p $TESTFLIGHT_DIR_PATH
    echo "Directory created: $(ls -ld $TESTFLIGHT_DIR_PATH)"

    # 必要なコミット数だけ履歴を取得する（git rev-list だとうまくいかなかったので、一旦、500 にしておく）
    git fetch --deepen 500

    # 直近のタグを取得
    LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null)

    # Merge pull request の commit だけを取得して見やすいように 1 行空ける
    if [ -z "$LATEST_TAG" ]; then
        # タグがない場合
        echo "No tags found. Writing log to $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt"
        git log HEAD --oneline --merges --pretty=format:"[%cs] %s %b" | sed -E 's|Merge pull request #[0-9]+ from [^/]+/||' | awk '{print $0 "\n"}' > $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt
    else
        # タグがある場合
        echo "Latest tag found: $LATEST_TAG. Writing log to $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt"
        git log $LATEST_TAG..HEAD --oneline --merges --pretty=format:"[%cs] %s %b" | sed -E 's|Merge pull request #[0-9]+ from [^/]+/||' | awk '{print $0 "\n"}' > $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt
    fi

    # ファイルが正しく作成されたか確認
    if [ -f "$TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt" ]; then
        echo "File created successfully: $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt"
        echo "File contents:"
        cat $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt
    else
        echo "Error: File not created: $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt"
    fi
fi
