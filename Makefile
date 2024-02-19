PACKAGE_NAME := DISampleAppPackage
SOURCE_DIR:= ./$(PACKAGE_NAME)/Sources/Domain/Protocol
MOCKOLO_OUTPUT := ./$(PACKAGE_NAME)/Sources/Domain/TestToolkit/Mock/MockoloMocks.swift

.PHONY: help
help:
	@awk 'BEGIN {FS = ":"} /^[a-zA-Z0-9_-]+:/ {if ($$2 == "") print "make " $$1}' Makefile

.PHONY: mockolo-run
mockolo-run:
	swift run --package-path $(PACKAGE_NAME) mockolo -s $(SOURCE_DIR) -d $(MOCKOLO_OUTPUT) -x Images Strings --mock-final
