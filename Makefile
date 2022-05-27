.PHONY: bundle permissions rubocop-schema

SHELL := $(shell command -v bash) -e
BASH_ENV := .env
export BASH_ENV

TOP := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
BUNDLE_APP_CONFIG := $(TOP)
export BUNDLE_APP_CONFIG
HOMEBREW := $(TOP)Library/Homebrew

bundle:
	@bundle install
	@bundle binstubs --all

install-bundler:
	@gem install bundler

permissions:
	@sudo chmod -R g+w /Library/Developer /Library/Java /Library/Perl  /Library/Python /Library/Ruby /usr/local
	@sudo chown -R :admin /Library/Developer /Library/Java /Library/Perl /Library/Python /Library/Ruby /usr/local

rubocop-schema:
	@bundle exec rubocop-schema-gen --build-repo=$(TOP) && rm -f rubocop-*.json
