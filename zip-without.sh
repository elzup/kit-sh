#!/bin/bash

# Create a zip file excluding specific directories.

# Usage: zip-without.sh <zip_file> <directory> <exclude_directories>

# <zip_file>: The name of the zip file to create.
# <directory>: The directory to zip.
# <exclude_directories>: A space-separated list of directories to exclude.

zip_file="$1"
directory="$2"
exclude_directories="$3"

# Create the zip file.
zip -r "$zip_file" "$directory" \
  $(for dir in $exclude_directories; do echo "-x '$directory/$dir/*'"; done)

echo "Created zip file: $zip_file"
