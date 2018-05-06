#!/bin/bash
# Connect to proxy server and catch connections to multiple ports
ssh -t mark@proxy \
  -R 40080:localhost:80 \
  -R 40443:localhost:443 \
  -R 48080:localhost:8080 \
  -R 48443:localhost:8443 \
  -R 41194:localhost:1194 \
"
  echo 'Forwarding ports, Ctrl+C to exit'
  sudo socat TCP-LISTEN:80,fork TCP:localhost:40080 &
  sudo socat TCP-LISTEN:443,fork TCP:localhost:40443 &
  sudo socat TCP-LISTEN:8080,fork TCP:localhost:48080 &
  sudo socat TCP-LISTEN:8443,fork TCP:localhost:48443 &
  sudo socat TCP-LISTEN:1194,fork TCP:localhost:41194 
"
