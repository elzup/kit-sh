#!/usr/bin/env bash

# pick b.y

cd jq-yq

cat abc1.json | jq '. + {
	b: [.b | to_entries[] | select(.key | startswith("z"))] |from_entries
}' > abc1-out.json

diff -u abc1.json abc1-out.json