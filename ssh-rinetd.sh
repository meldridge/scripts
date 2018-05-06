#!/bin/bash
# Connect to proxy server and set up remote forwarding with rinetd
ssh -t mark@proxy \
  -R 40080:localhost:80 \
  -R 40443:localhost:443 \
  -R 48080:localhost:8080 \
  -R 48443:localhost:8443 \
  -R 41194:localhost:1194 \
  'sudo service rinetd start; bash -l'
ssh mark@proxy 'sudo service rinetd stop'
