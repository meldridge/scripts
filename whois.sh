#!/bin/bash

if [ -z $1 ]; then
  echo "No IP list provided."
  echo "Usage: ./whois.sh <IP-list.txt>"
  exit 0
fi

# Perform whois lookup on all provided IPs
while read ip; do
  $(whois $ip) > "whois-$ip.txt"
done < "$1"
