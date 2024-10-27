#!/bin/bash

if [ -z $1 ]
then
    echo "Usage: $0 <sensor_name>"
    exit 1
fi
sensor_name=$1

start=$(date +%s)
echo "Sensor $sensor_name started at $(date)"

while [ $((start+10)) -gt $(date +%s) ]
do
    # take a reading
    reading=$((RANDOM%100))
    echo "Reading: $reading"
    echo "$sensor_name,$reading,$(date +%s)" >> sensor.log
    # sleep for 1-3 seconds
    sleep $((RANDOM%3+1))
done