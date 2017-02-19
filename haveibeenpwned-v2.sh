#!/bin/bash
if [ -z "$1" ]; then
	echo "Usage: ./haveibeenpwned.sh <email list>"
  exit 0
fi

echo "Checking haveibeenpwned.com using v2 of API:"
echo ""

while read email; do

  encodedEmail=${email//@/%40}
  url="https://haveibeenpwned.com/api/v2/breachedaccount/$encodedEmail?truncateResponse=true"
  response=$(curl --write-out %\{http_code\} --silent --output /dev/null $url)
  
  sleep 1

  echo -n "Checking if $email has been pwned: "
  if [ "$response" == "200" ]; then
    detail=$(curl --silent $url)
    echo "YES - $detail"
  else
    echo "NO"
  fi

done < $1
