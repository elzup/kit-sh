#!/usr/bin/env bash


copy_up_dir() {
    local file_path="$1"
    local parent_dir="$(dirname "$file_path")"
    local grandparent_dir="$(dirname "$parent_dir")"
    local destination="$(dirname "$grandparent_dir")"

    if [ -f "$file_path" ] && [ -s "$file_path" ]; then
        rsync -av "$file_path" "$destination/"
        echo "$file_path copied"
    else
        echo "$file_path none"
    fi
}

copy_up_dir "/home/pi/project/buspro-obe-framework/launch_endpoint/start_obe.sh"
copy_up_dir "/home/pi/project/buspro-obe-framework/launch_endpoint/git_fix.sh"
