#!/bin/bash
# Connect to proxy server and set up remote forwarding with rinetd
ssh -t mark@proxy -R 40443:localhost:443 'sudo service rinetd start; bash -l'
ssh mark@proxy 'sudo service rinetd stop'
