PACKAGE_NAME := ./DISampleAppPackage
MOCKOLO_SCAN_PATH := ./$(PACKAGE_NAME)/Sources
MOCKOLO_OUTPUT_PATH := ./$(PACKAGE_NAME)/Sources/Presentation/Domain/Entity/Mocks.swift

.PHONY: help
help:
	@awk 'BEGIN {FS = ":"} /^[a-zA-Z0-9_-]+:/ {if ($$2 == "") print "make " $$1}' Makefile

.PHONY: mint-bootstrap
mint-bootstrap:
	swift run --package-path $(PACKAGE_NAME) mint bootstrap

.PHONY: githooks-setup
githooks-setup:
	git config --local core.hooksPath .githooks

.PHONY: githooks-cleanup
githooks-cleanup:
	git config --local --unset core.hooksPath .githooks

.PHONY: swiftformat-run
swiftformat-run:
	swift run --package-path $(PACKAGE_NAME) mint run swiftformat .

.PHONY: swiftformat-lint
swiftformat-lint:
	swift run --package-path $(PACKAGE_NAME) mint run swiftformat --lint .

.PHONY: mockolo-run
mockolo-run:
	swift run --package-path $(PACKAGE_NAME) mint run mockolo -s $(MOCKOLO_SCAN_PATH) -d $(MOCKOLO_OUTPUT_PATH) --custom-imports DomainLayer Combine -x Images Strings --mock-final

.PHONY: sourcery-presentation-code-gen
sourcery-presentation-code-gen:
	./sourcery/script/presentation_code_gen.sh $(VIEW) $(ROUTER)

.PHONY: presentation-code-gen
presentation-code-gen:
	$(MAKE) sourcery-presentation-code-gen
	$(MAKE) mockolo-run

.PHONY: sourcery-driver-code-gen
sourcery-driver-code-gen:
	./sourcery/script/driver_code_gen.sh $(DRIVER)

.PHONY: driver-code-gen
driver-code-gen:
	$(MAKE) sourcery-driver-code-gen
	$(MAKE) mockolo-run

.PHONY: sourcery-use-case-code-gen
sourcery-use-case-code-gen:
	./sourcery/script/use_case_code_gen.sh $(USECASE)

.PHONY: use-case-code-gen
use-case-code-gen:
	$(MAKE) sourcery-use-case-code-gen
	$(MAKE) mockolo-run

.PHONY: swift-docc-gen
swift-docc-gen:
	./swift_docc/script/docc_gen.sh $(PACKAGE_NAME)

.PHONY: periphery-scan
periphery-scan:
	./periphery/script/periphery_scan.sh $(CURDIR)

.PHONY: spm-dependencies-mermaid-gen
spm-dependencies-mermaid-gen:
	./depermaid/script/spm_dependencies_mermaid_gen.sh

.PHONY: document-update
document-update:
	$(MAKE) swift-docc-gen
	$(MAKE) periphery-scan
	$(MAKE) spm-dependencies-mermaid-gen

.PHONY: setup
setup:
	$(MAKE) mint-bootstrap
	$(MAKE) githooks-setup
	$(MAKE) open

.PHONY: cleanup
cleanup:
	$(MAKE) githooks-cleanup
