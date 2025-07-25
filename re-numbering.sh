# frame_d_0213.jpg
# frame_d_0214.jpg
# frame_d_0216.jpg
# ↓
# frame_d_0001.jpg
# frame_d_0002.jpg
# frame_d_0003.jpg

#!/bin/bash

target_dir="$1"

if [ -z "$target_dir" ]; then
  echo "Usage: $0 <target_directory>"
  exit 1
fi
if [ ! -d "$target_dir" ]; then
  echo "Error: Directory '$target_dir' does not exist."
  exit 1
fi
cd "$target_dir" || exit 1
count=1
for file in frame_d_*.jpg; do
  if [[ -f "$file" ]]; then
    new_name=$(printf "frame_d_%04d.jpg" "$count")
    mv "$file" "$new_name"
    echo "Renamed '$file' to '$new_name'"
    count=$((count + 1))
  fi
done
echo "Renaming completed."
exit 0