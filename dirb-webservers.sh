#!/bin/bash
if [ -z "$1" ]; then
	echo "Usage: ./dirb-webservers.sh <IP list>";
	exit 0;
fi

echo "dirb scanning addresses from $1";

while read ip
do
	dirb "https://$ip" -o "$ip-https.txt"
done < "$1"