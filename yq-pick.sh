#!/usr/bin/env bash

# pick paths./b/*
yq  '. + { paths: [.paths | to_entries[] | select(.key | startswith("/b"))] |from_entries }' ./data/a.yml 

