SWIFT_PACKAGE_VERSION := $(shell swift package tools-version)

lint-fix:
	mint run swiftlint --fix --quiet
	mint run swiftformat --quiet --swiftversion ${SWIFT_PACKAGE_VERSION} .

test: genLinuxTests
	swift test

clean:
	swift package reset
	rm -rdf .swiftpm/xcode
	rm -rdf .build/
	rm Package.resolved
	rm .DS_Store

cleanArtifacts:
	swift package clean

latest:
	swift package update

resolve:
	swift package resolve

