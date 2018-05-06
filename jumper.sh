#!/bin/bash
# Connect to jumper and set up remote forwarding
ssh -t mark@jumper -R 40080:localhost:80 -R 40443:localhost:443 -R 48080:localhost:8080 -R 48443:localhost:8443 -R 44444:localhost:4444 -R 41194:localhost:1194 'sudo service rinetd start; bash -l'
ssh mark@jumper 'sudo service rinetd stop'
