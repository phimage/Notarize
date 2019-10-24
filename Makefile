PREFIX?=/usr/local

build:
		swift build --disable-sandbox -c release --static-swift-stdlib

clean_build:
		rm -rf .build
		make build

portable_zip: build
		rm -rf portable_notarize
		mkdir portable_v
		mkdir portable_notarizeh/bin
		cp -f .build/release/notarize portable_notarize/bin/notarize
		cp -f LICENSE portable_notarize
		cd portable_notarize
		(cd portable_notarize; zip -yr - "bin" "LICENSE") > "./portable_notarize.zip"
		rm -rf portable_notarize

install: build
		mkdir -p "$(PREFIX)/bin"
		cp -f ".build/release/notarize" "$(PREFIX)/bin/notarize"

current_version:
		@cat .version

bump_version:
		$(eval NEW_VERSION := $(filter-out $@,$(MAKECMDGOALS)))
		@echo $(NEW_VERSION) > .version
		@sed 's/__VERSION__/$(NEW_VERSION)/g' script/Version.swift.template > Sources/NotarizeFrontend/Version.swift
		git commit -am"Bump version to $(NEW_VERSION)"

%:
	@:
