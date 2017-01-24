#!/bin/bash
if [ -z "$1" ]; then
	echo "Usage: ./dig.sh <IP list>";
	exit 0;
fi
echo "dig reverse lookups from $1";

while read ip
do
	dig -x "$ip"
done < "$1"