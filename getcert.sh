#!/bin/bash
# Pull the raw (non-servername) certificate from the given host/domain, and store the output
if [[ -z $1 ]] || [[ ! -d $2 ]]; then
	echo "Usage: ./getcert.sh <host> <path>"
  exit 0
fi

DOMAIN=$1
FILE=$2/$(date +"%Y%m%d_%H%M")_$DOMAIN.txt

echo | openssl s_client -connect $DOMAIN:443 2>/dev/null | openssl x509 -inform pem -noout -text > $FILE
