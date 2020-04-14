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
	@git status
	@rm -rf .git download.sh
	@git init
	@git status
	@git add .gitignore
	@git status
	@echo -e "\nMakefile\n.gitignore" > .gitignore
	@git status
	@git add .
	@git commit -m "Initial commit"
	@git checkout -- .
	@rm -f Makefile
