#!/bin/bash
# Recursively fix ownership and permissions in the current directory
sudo find . -type f -exec chown mark: {} \;
sudo find . -type f -exec chmod 664 {} \;
