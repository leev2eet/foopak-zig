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

extra_find_filters=();

if [ -n "$filter_arg" ]; then
	filter_path=${filter_arg//\./\/};
	extra_find_filters+=('-path' "*/$filter_path*");
fi

test_files=$(find \
	"${project_root:?}/tests" \
	-name '*.zig' \
	-not -path '*/zig-cache/*' \
	"${extra_find_filters[@]}" \
);

exit_status=0;
IFS=$'\n'; for test_file in $test_files; do
	echo "Running ${test_file#$project_root\/tests\/}...";
	zig test -lc --main-pkg-path "$project_root" "$test_file";
	test_status=$?;

	if [ "$test_status" != "0" ]; then
		exit_status=1
	fi
done

exit $exit_status;
