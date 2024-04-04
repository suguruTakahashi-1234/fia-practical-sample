PACKAGE_NAME := ./DISampleAppPackage
MOCKOLO_SCAN_PATH := ./$(PACKAGE_NAME)/Sources
MOCKOLO_OUTPUT_PATH := ./$(PACKAGE_NAME)/Sources/Presentation/Domain/Entity/Mocks.swift

# help コマンド
.PHONY: help
help:
	@awk 'BEGIN {FS = ":"} /^[a-zA-Z0-9_-]+:/ {if ($$2 == "") print "make " $$1}' Makefile

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

.PHONY: sourcery-presentation-code-gen
sourcery-presentation-code-gen:
	./sourcery/script/presentation_code_gen.sh $(VIEW) $(ROUTER)

# Presentation 層のコード生成
.PHONY: presentation-code-gen
presentation-code-gen:
	$(MAKE) sourcery-presentation-code-gen
	$(MAKE) mockolo-run

.PHONY: sourcery-driver-code-gen
sourcery-driver-code-gen:
	./sourcery/script/driver_code_gen.sh $(DRIVER)

# Driver のコード生成
.PHONY: driver-code-gen
driver-code-gen:
	$(MAKE) sourcery-driver-code-gen
	$(MAKE) mockolo-run

.PHONY: sourcery-use-case-code-gen
sourcery-use-case-code-gen:
	./sourcery/script/use_case_code_gen.sh $(USECASE)

# UseCase のコード生成
.PHONY: use-case-code-gen
use-case-code-gen:
	$(MAKE) sourcery-use-case-code-gen
	$(MAKE) mockolo-run

# Swift-DocC によるドキュメント生成
.PHONY: swift-docc-gen
swift-docc-gen:
	./swift_docc/script/docc_gen.sh $(PACKAGE_NAME)

# Periphery によるコードの静的解析
.PHONY: periphery-scan
periphery-scan:
	./periphery/script/periphery_scan.sh $(CURDIR)

# Swift Package Manager の依存関係の Mermaid 生成
.PHONY: spm-dependencies-mermaid-gen
spm-dependencies-mermaid-gen:
	./depermaid/script/spm_dependencies_mermaid_gen.sh

# ドキュメントのアップデート
.PHONY: document-update
document-update:
	$(MAKE) swift-docc-gen
	$(MAKE) periphery-scan
	$(MAKE) spm-dependencies-mermaid-gen

