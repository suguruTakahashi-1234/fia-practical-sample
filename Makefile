PACKAGE_NAME := DISampleAppPackage
MOCKOLO_SCAN_PATH := ./$(PACKAGE_NAME)/Sources/Domain
MOCKOLO_OUTPUT_PATH := ./$(PACKAGE_NAME)/Sources/Presentation/TestTool/DomainLayerMocks.swift

.PHONY: help
help:
	@awk 'BEGIN {FS = ":"} /^[a-zA-Z0-9_-]+:/ {if ($$2 == "") print "make " $$1}' Makefile

.PHONY: mockolo-run
mockolo-run:
	swift run --package-path $(PACKAGE_NAME) mockolo -s $(MOCKOLO_SCAN_PATH) -d $(MOCKOLO_OUTPUT_PATH) --custom-imports DomainLayer -x Images Strings --mock-final
