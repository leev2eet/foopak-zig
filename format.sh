#!/bin/bash

project_root=$(realpath $(dirname "${BASH_SOURCE[0]}"))

filter_arg=$1
check_flag=$2

if [ "$filter_arg" == "--help" ]; then
	executable=$0;

cat << EOF
Usage: $executable [FILTER] [CHECK ONLY]

eg.:
	'$executable' formats all files
	'$executable list' formats all files inside directory 'list'
	'$executable list 1' checks all files inside directory 'list' without changing them

EOF

	exit 0;
fi

extra_find_filters=();

if [ -n "$filter_arg" ]; then
	filter_path=${filter_arg//\./\/};
	extra_find_filters+=('-path' "*/$filter_path*");
fi

extra_fmt_args=();

if [ "$check_flag" == "1" ]; then
	extra_fmt_args+=('--check');
fi

source_files=$(find \
	"${project_root:?}" \
	-name '*.zig' \
	-not -path '*/zig-cache/*' \
	"${extra_find_filters[@]}" \
);


exit_status=0
IFS=$'\n'; for src_file in $source_files; do
	echo "Checking '${src_file}'...";
	zig fmt "${extra_fmt_args[@]}" "${src_file}";
	fmt_status=$?;
	if [ "$fmt_status" != "0" ]; then
		exit_status=0;
	fi
done;

exit $exit_status;
