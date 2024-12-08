define USAGE
Tool for building a browser extension for Chrome or Firefox
Usage: make [options] [target] ...

Targets:
endef
export USAGE

help: ##		Show this help.
	@echo "$$USAGE" && fgrep -h "##" $(firstword $(MAKEFILE_LIST)) | sed 's/\([^ ]*\).*##\(.*\)/  \1\t\2/g' | fgrep -v 'fgrep'

link\:firefox: ## link manifest.json for Firefox
	@cd src && rm manifest.json && ln -s manifest-v2.json manifest.json

link\:chrome: ## link manifest.json for Chrome
	@cd src && rm manifest.json && ln -s manifest-v3.json manifest.json

icon: ## generate icon
	@magick convert -background transparent "src/favicon.png" "src/favicon@2x.png" -colors 256 -define icon:auto-resize=16,32 "favicon.ico"

build: ## create bundle for an extension
	@web-ext build -s src -a build

sign: ## sign an extension for Firefox
	@web-ext sign -s src --api-key=$AMO_JWT_ISSUER --api-secret=$AMO_JWT_SECRET -a build

firefox: ## build for Firefox
	@make link:firefox build

chrome: ## build for Chrome
	@make link:chrome build

.PHONY: build