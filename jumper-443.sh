#!/bin/bash
# Connect to jumper and set up remote forwarding for ports 80 and 443
ssh -t ubuntu@jumper -i ~/.ssh/Jumper_Frankfurt.pem -R 40443:localhost:443 'sudo service rinetd start; bash -l'
ssh ubuntu@jumper -i ~/.ssh/Jumper_Frankfurt.pem 'sudo service rinetd stop'
