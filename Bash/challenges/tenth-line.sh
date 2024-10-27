#!/bin/bash

# Read from the file file.txt and output the tenth line to stdout.

# Solution 1
awk 'NR == 10' file.txt

# Solution 2
sed -n 10p file.txt

# Solution 3
tail -n+10 file.txt | head -n1

# Solution 4
awk 'FNR == 10 {print $0}' file.txt

# Solution 5
awk 'NR == 10 {print $0}' file.txt


filename="file.txt"
if [ $(wc -l < "$filename") -ge 10 ]; then
    head -n 10 "$filename" | tail -n 1
fi