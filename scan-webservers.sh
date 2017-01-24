#!/bin/bash
# Uses nmap to scan for webservers in the given IP list, 
# then performs dirb/nikto and NSE http-* scanning

if [ -z "$1" ]; then
	echo "Usage: ./nmap-webservers.sh <IP list>";
fi

ips=$1;
echo "Performing webserver scans on IP list: $ips";

nmap -n -v -sn -oG nmap_pingscan_$(date +"%Y%m%d-%H%M").gnmap -iL $ips;
grep 