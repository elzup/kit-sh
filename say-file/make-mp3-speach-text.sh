#!/usr/bin/env bash

/usr/bin/say -v Kyoko $TEXT
/usr/bin/say -v Kyoko $TEXT -o tmp.aiff
ffmpeg -i tmp.aiff voice.mp3
