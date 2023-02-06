#!/usr/bin/env bash

ips=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
# print IP http links

for ip in $ips; do
	echo "http://$ip"
done

