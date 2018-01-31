#!/bin/bash
# Performs a reverse dns lookup across the provided IP range (/24)

if [ -z "$1" ]; then
	echo "Usage: ./rev-dns.sh <subnet/24>"
  exit 0
fi

subnet=$1

for ip in $(seq 1 254); do
  host $subnet.$ip
done
