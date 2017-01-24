#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: ./webroot-brute.sh <wordlist> <url>"
  exit 0
fi

while read filename; do
  url=$2$filename
  response=$(wget -S --spider --max-redirect=0 $url 2>&1 | grep "HTTP/1.1 200 OK")

  result="YES"
  if [ -z "$response" ]; then
    result="NO"
  fi

  echo "Looking for $url: $result"
done < $1
