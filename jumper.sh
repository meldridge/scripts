#!/bin/bash
# Connect to jumper and set up remote forwarding for ports 80 and 443
ssh -t root@jumper -R 40080:localhost:80 -R 48080:localhost:8080 -R 40443:localhost:443 -R 48443:localhost:8443 -R 44444:localhost:4444 'service rinetd start; bash -l'
ssh root@jumper 'service rinetd stop'
