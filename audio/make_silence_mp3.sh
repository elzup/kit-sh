#!/usr/bin/env bash

output_file="silent.mp3"
duration=0.1
ffmpeg -f lavfi -i anullsrc=r=44100:cl=stereo -t $duration $output_file