# !/bin/bash 

# read specific line from file
read -p "Enter the line number: " line
sed -n "${line}p" sensor.log
