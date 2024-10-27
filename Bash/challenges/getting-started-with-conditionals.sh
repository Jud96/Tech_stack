#!/bin/bash

read character

# if the character is 'y' or 'Y', print 'YES' else print 'NO'

if [ $character == 'y' ] || [ $character == 'Y' ]; then
    echo "YES"
else
    echo "NO"
fi