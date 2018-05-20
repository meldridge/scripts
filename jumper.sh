#!/bin/bash
# Connect to jumper and set up remote forwarding for ports 80, 443, 8080, 8443, and 1194
ssh root@jumper -R 80:localhost:80 -R 443:localhost:443 -R 8080:localhost:8080 -R 8443:localhost:8443 -R 1194:localhost:1194
