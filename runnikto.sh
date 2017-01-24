#!/bin/bash
# Runs nikto against all of the hosts in the given file, on the provided port

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: ./runnikto.sh <hostfile> <port>"
  exit 0
fi

PORT=$2

while read host; do
  
  # Run nikto against each host, writing to a file
  OUTFILE="nikto_"$host"-p"$PORT"_$(date +"%Y%m%d_%H%M").txt"

  #echo $OUTFILE
  nikto -host $host -port $PORT -output $PWD/$OUTFILE < /dev/null

done < $1
