PACKAGE_NAME := ./DISampleAppPackage
MOCKOLO_SCAN_PATH := ./$(PACKAGE_NAME)/Sources
MOCKOLO_OUTPUT_PATH := ./$(PACKAGE_NAME)/Sources/Presentation/TestTool/Mocks.swift

.PHONY: help
help:
	@awk 'BEGIN {FS = ":"} /^[a-zA-Z0-9_-]+:/ {if ($$2 == "") print "make " $$1}' Makefile

.PHONY: mint-bootstrap
mint-bootstrap:
	swift run --package-path $(PACKAGE_NAME) mint bootstrap

.PHONY: swiftformat-run
swiftformat-run:
	swift run --package-path $(PACKAGE_NAME) swiftformat .

.PHONY: swiftformat-lint
swiftformat-lint:
	swift run --package-path $(PACKAGE_NAME) swiftformat --lint .

.PHONY: mockolo-run
mockolo-run:
	swift run --package-path $(PACKAGE_NAME) mint run mockolo -s $(MOCKOLO_SCAN_PATH) -d $(MOCKOLO_OUTPUT_PATH) --custom-imports DomainLayer -x Images Strings --mock-final

.PHONY: sourcery-presentation-code-gen
sourcery-presentation-code-gen:
	./Sourcery/Script/presentation_code_gen.sh $(VIEW) $(ROUTER)

.PHONY: presentation-code-gen
presentation-code-gen:
	$(MAKE) sourcery-presentation-code-gen
	$(MAKE) mockolo-run

.PHONY: setup
setup:
	$(MAKE) mint-bootstrap
	$(MAKE) open
