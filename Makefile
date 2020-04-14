.ONESHELL:
.SHELL := /usr/bin/bash
.PHONY: backup clean init

backup:
	@export BACKUP_TS="$$(date +%s)"
	@export BACKUP_SOURCE="$$(pwd)"
	@export BACKUP_TARGET="$${BACKUP_SOURCE}.$${BACKUP_TS}.backup"
	@cp -r "$$BACKUP_SOURCE" "$$BACKUP_TARGET"

clean:
	@find . -name '*.backup' -print -exec rm -f {} +

init:
	@type git > /dev/null || exit 1
	@rm -rf .git download.sh
	@git init
	@git add .gitignore
	@echo "Makefile" .gitignore && echo ".gitignore" >> .gitignore
	@git add .
	@git commit -m "Initial commit"
	@git checkout -- .
	@rm -f Makefile
