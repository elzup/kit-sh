#!/usr/bin/env bash

/usr/bin/say -v Kyoko $TEXT
/usr/bin/say -v Kyoko $TEXT -o out/tmp.aiff
ffmpeg -i out/tmp.aiff out/voice.mp3
