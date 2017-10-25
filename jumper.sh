#!/bin/bash
# Connect to jumper and set up remote forwarding for ports 80 and 443
ssh -t ubuntu@jumper -i ~/.ssh/Jumper_Frankfurt.pem -R 40080:localhost:80 -R 48080:localhost:8080 -R 40443:localhost:443 -R 48443:localhost:8443 -R 44444:localhost:4444 -R 41194:localhost:1194 'sudo service rinetd start; bash -l'
ssh ubuntu@jumper -i ~/.ssh/Jumper_Frankfurt.pem 'sudo service rinetd stop'
