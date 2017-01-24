#!/bin/bash
# Uses tcpdump to capture packets to/from the given host, and outputs simultaneously to a file and stdout.
# The capture file is prefixed with the date and time, and suffixed with the second parameter.

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: ./capture.sh <host> <suffix>"
  exit 0
fi

HOST=$1
NAME=$2

# Run tcpdump, pipe to output file via tee, and output back to stdout
sudo tcpdump -nn -l -U -w - host $HOST | tee $(date +"%Y%m%d_%H%M")_$NAME.pcap | tcpdump -nn -r - -l -U
