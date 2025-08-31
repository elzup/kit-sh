#!/bin/bash
set -euo pipefail

script_name="urlcache"

if [ $# -lt 1 ]; then
  echo "Usage: $0 <file>" 1>&2
  exit 1
fi

input_file="$1"
export_dir="${script_name}-exported"
mkdir -p "$export_dir"

# Extract URLs from the file (while readで配列化)
urls=()
local_paths=()
while IFS= read -r url; do
  urls+=("$url")
done < <(grep -Eo 'https?://[^,]+' "$input_file" | sort | uniq)
url_count=${#urls[@]}

if [ "$url_count" -eq 0 ]; then
  echo "No URLs found in $input_file."
  exit 0
fi

echo "Downloading $url_count URLs..."
for url in "${urls[@]}"; do
  # URLのsha1ハッシュ値を生成
  hash=$(echo -n "$url" | shasum | awk '{print $1}')
  filename="${hash}.jpg"
  local_path="$export_dir/$filename"
  curl -sSL "$url" -o "$local_path"
  local_paths+=("$local_path")
done

tmp_file="${input_file}.tmp"
cp "$input_file" "$tmp_file"

# Replace URLs with local paths
for i in "${!urls[@]}"; do
  url="${urls[$i]}"
  local_path="${local_paths[$i]}"
  rel_path="$(basename "$local_path")"
  sed -i "" "s|$url|$export_dir/$rel_path|g" "$tmp_file"
done

output_file="$export_dir/$(basename "$input_file")"
mv "$tmp_file" "$output_file"

# Summary
echo "--- Summary ---"
echo "Input file: $input_file"
echo "Output file: $output_file"
echo "Exported directory: $export_dir"
echo "URLs processed: $url_count"
for i in "${!urls[@]}"; do
  echo "  ${urls[$i]} -> $export_dir/$(basename "${local_paths[$i]}")"
done
