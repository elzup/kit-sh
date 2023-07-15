#!/usr/bin/env bash

OUT_DIR=out
TMP_FILE=$OUT_DIR/tmp.aiff
OUT_FILE=$OUT_DIR/voice.mp3

/usr/bin/say -v Kyoko $TEXT
/usr/bin/say -v Kyoko $TEXT -o $TMP_FILE
ffmpeg -i $TMP_FILE $OUT_FILE
rm $TMP_FILE
