#!/bin/bash
if [ -z "$1" ]; then
	echo "Usage: ./haveibeenpwned.sh <email list>"
  exit 0
fi

while read email; do

  encodedEmail=${email//@/%40}
  url="https://haveibeenpwned.com/api/breachedaccount/$encodedEmail"
  response=$(curl --write-out %\{http_code\} --silent --output /dev/null $url)

  echo -n "Checking if $email has been pwned: "
  if [ "$response" == "200" ]; then
    detail=$(curl --silent $url)
    echo "YES - $detail"
  else
    echo "NO"
  fi

done < $1
