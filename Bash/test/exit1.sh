#!/bin/bash

package=notexist

sudo apt update && sudo apt install -y $package >> package_install_result.log

if [ $? -eq 0 ]
then
    echo "Command exists"
else
    echo "Command does not exist" >> package_install_failure.log
fi

