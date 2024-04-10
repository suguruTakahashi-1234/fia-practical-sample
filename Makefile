PACKAGE_NAME := ./DISampleAppPackage
MOCKOLO_SCAN_PATH := ./$(PACKAGE_NAME)/Sources
MOCKOLO_OUTPUT_PATH := ./$(PACKAGE_NAME)/Sources/Presentation/Domain/Entity/Mocks.swift

# help コマンド
.PHONY: help
help:
	@awk 'BEGIN {comment = ""} /^#/ {comment = substr($$0, 3)} /^[a-zA-Z0-9_-]+:/ {if (length(comment) > 0) {printf "%-40s %s\n", "make " substr($$0, 1, index($$0, ":")-1), comment; comment = ""}}' Makefile

# プロジェクトのセットアップ
.PHONY: setup
setup:
	$(MAKE) mint-bootstrap
	$(MAKE) githooks-setup
	$(MAKE) open

# プロジェクトのクリーンアップ
.PHONY: cleanup
cleanup:
	$(MAKE) githooks-cleanup

# Xcode の起動
.PHONY: open
open:
	open `find . -maxdepth 1 -mindepth 1 -iname "*.xcworkspace"`

# mint の初期化
.PHONY: mint-bootstrap
mint-bootstrap:
	swift run --package-path $(PACKAGE_NAME) mint bootstrap

# githooks のセットアップ
.PHONY: githooks-setup
githooks-setup:
	git config --local core.hooksPath .githooks

# githooks のクリーンアップ
.PHONY: githooks-cleanup
githooks-cleanup:
	git config --local --unset core.hooksPath .githooks

# SwiftFormat の実行
.PHONY: swiftformat-run
swiftformat-run:
	swift run --package-path $(PACKAGE_NAME) mint run swiftformat .

# SwiftFormat の dryrun
.PHONY: swiftformat-dryrun
swiftformat-dryrun:
	swift run --package-path $(PACKAGE_NAME) mint run swiftformat --lint .

# Mockolo によるモックファイルの自動生成
.PHONY: mockolo-run
mockolo-run:
	swift run --package-path $(PACKAGE_NAME) mint run mockolo -s $(MOCKOLO_SCAN_PATH) -d $(MOCKOLO_OUTPUT_PATH) --custom-imports DomainLayer Combine -x Images Strings --mock-final

# Presentation 層のコード生成 ex) make presentation-code-gen ROUTER=AppRoot VIEW=Hoge
.PHONY: presentation-code-gen
presentation-code-gen:
	./sourcery/script/presentation_code_gen.sh $(ROUTER) $(VIEW)
	$(MAKE) mockolo-run

# Driver のコード生成 ex) make driver-code-gen DRIVER=Hoge
.PHONY: driver-code-gen
driver-code-gen:
	./sourcery/script/driver_code_gen.sh $(DRIVER)
	$(MAKE) mockolo-run

# UseCase のコード生成 ex) make use-case-code-gen ROUTER=AppRoot USECASE=Hoge
.PHONY: use-case-code-gen
use-case-code-gen:
	./sourcery/script/use_case_code_gen.sh $(ROUTER) $(USECASE)
	$(MAKE) mockolo-run

# Swift-DocC によるドキュメントのローカル環境でのプレビュー
.PHONY: swift-docc-preview
swift-docc-preview:
	swift package --package-path $(PACKAGE_NAME) --disable-sandbox preview-documentation --target DomainLayer

# Swift-DocC によるドキュメント生成（GitHub Actions に移行済み、検証時のみ使用する）
.PHONY: swift-docc-gen
swift-docc-gen:
	./swift_docc/script/docc_gen.sh
	$(MAKE) swift-docc-preview

# Periphery によるコードの静的解析
.PHONY: periphery-scan
periphery-scan:
	./periphery/script/periphery_scan.sh $(CURDIR)

# Swift Package Manager の依存関係の Mermaid 生成
.PHONY: spm-dependencies-mermaid-gen
spm-dependencies-mermaid-gen:
	./depermaid/script/spm_dependencies_mermaid_gen.sh

# ドキュメントのアップデート(Periphery, Mermaid)
.PHONY: document-update
document-update:
	$(MAKE) periphery-scan
	$(MAKE) spm-dependencies-mermaid-gen
