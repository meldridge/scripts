#!/bin/bash
# Connect to jumper and set up remote forwarding for ports 80 and 443
ssh root@jumper -R 8080:localhost:80 -R 8443:localhost:443
