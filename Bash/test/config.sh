#!/bin/bash
command=/usr/bin/htop
if [ -f $command ]
then
    echo "Command exists"
else
    echo "Command does not exist"
    sudo apt update && sudo apt install -y htop
fi