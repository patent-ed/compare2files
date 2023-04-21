#!/bin/bash

# Check if the correct number of arguments is provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 file1 file2 output_file"
    exit 1
fi

file1="$1"
file2="$2"
output_file="$3"

# Compare the files using the diff command with the -u option for unified format
diff -u "$file1" "$file2" > /tmp/diff_output

# Add explanations to the diff output
sed -e '1,2d' \
    -e 's/^---/File 1: ---/' \
    -e 's/^+++/File 2: +++/' \
    -e 's/^-/Removed: -/' \
    -e 's/^+/Added:   +/' \
    -e 's/^@/@ Line(s) in file 1, line(s) in file 2: /' \
    /tmp/diff_output > "$output_file"

# Print a success message and exit
echo "Differences saved to $output_file"
exit 0
