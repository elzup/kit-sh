#!/bin/bash

usage() {
    echo "Usage: $0 input_file output_file"
    exit 1
}

if [ "$#" -ne 1 ]; then
    usage
fi

input_file="$1"

if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

shuf "$input_file"
