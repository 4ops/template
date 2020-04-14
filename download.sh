#!/bin/sh

set -eu

readonly current_dir="$(pwd)"
readonly this_script="${current_dir}/download.sh"
readonly update_url="https://raw.githubusercontent.com/4ops/template/master"
readonly update_files=".editorconfig .gitignore .pre-commit-config.yaml LICENSE"

error() {
	echo "$@" >&1
	exit 1
}

make_backup() {
	local ts
	ts="$(date +%s)"
	for fn in $update_files; do
		if [ -r "${current_dir}/${fn}" ]; then
			cp -vr "${current_dir}/${fn}" "${current_dir}/${fn}.${ts}.backup" \
			|| error "Failed to backup ${fn}"
		fi
	done
}

update_files() {
	for fn in $update_files; do
		wget -q -t 2 -O "${current_dir}/${fn}" "${update_url}/${fn}" \
		|| error "Failed to download ${fn}"
	done
}

make_backup
update_files
rm -f "$this_script"
