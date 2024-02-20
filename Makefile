PACKAGE_NAME := DISampleAppPackage
SOURCE_DOMAIN_DIR := ./$(PACKAGE_NAME)/Sources/Domain
SOURCE_PRESENTATION_DIR := ./$(PACKAGE_NAME)/Sources/Presentation

.PHONY: help
help:
	@awk 'BEGIN {FS = ":"} /^[a-zA-Z0-9_-]+:/ {if ($$2 == "") print "make " $$1}' Makefile

.PHONY: mockolo-run-domain
mockolo-run-domain:
	swift run --package-path $(PACKAGE_NAME) mockolo -s $(SOURCE_DOMAIN_DIR) -d $(SOURCE_DOMAIN_DIR)/DomainLayerMocks.swift -x Images Strings --mock-final

.PHONY: mockolo-run-presentation
mockolo-run-presentation:
	swift run --package-path $(PACKAGE_NAME) mockolo -s $(SOURCE_PRESENTATION_DIR) -d $(SOURCE_PRESENTATION_DIR)/PresentationLayerMocks.swift -x Images Strings --mock-final

.PHONY: mockolo-run
mockolo-run:
	$(MAKE) mockolo-run-domain
	$(MAKE) mockolo-run-presentation