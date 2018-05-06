#!/bin/bash
# Connect to proxy server and catch connections to port 443
ssh -t mark@proxy -R 40443:localhost:443 \
  'sudo socat TCP-LISTEN:443,fork TCP:localhost:40443'
