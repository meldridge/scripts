#!/bin/bash
# Runs dirb against all of the hosts in the given file, on the provided port

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: ./rundirb.sh <hostfile> <protocol>"
  exit 0
fi

PROTOCOL=$2

while read host; do
  
  # Run dirb against each host, writing to a file
  OUTFILE="dirb_"$PROTOCOL"-"$host"_$(date +"%Y%m%d_%H%M").txt"

  #echo $OUTFILE
  dirb "$PROTOCOL://$host/" -o $PWD/$OUTFILE < /dev/null

done < $1
