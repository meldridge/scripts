#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <wordlist>"
  exit 0
fi

wordlist=$1

while read i; do
    echo "Testing $i..."
    dig $i.domain.com +short
done < wordlist
