#!/bin/bash

project_root=$(realpath $(dirname "${BASH_SOURCE[0]}"))

filter_arg=$1

if [ "$filter_arg" == "--help" ]; then
	executable=$0;

cat << EOF
Usage: $executable [FILTER]

eg.:
	'$executable' runs all tests
	'$executable LinkedList' runs all tests inside directory 'LinkedList'
	'$executable LinkedList.create' runs all tests matching 'LinkedList/create'

EOF

	exit 0;
fi

extra_find_filters=()

if [ -n "$filter_arg" ]; then
	filter_path=${filter_arg//\./\/};
	extra_find_filters+=('-path' "*/$filter_path*");
fi

find \
	"${project_root:?}/tests" \
	-name '*.zig' \
	-not -path '*/zig-cache/*' \
	"${extra_find_filters[@]}" \
	|
	while read -r test_file_path; do
		echo "Running ${test_file_path#$project_root\/tests\/}...";
		zig test -lc --main-pkg-path "$project_root" "$test_file_path";
	done
