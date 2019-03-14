#!/bin/bash

#############################################################
#  Script built to identify newly spawned proccess + filters
############################################################

if [ -z "$1" ]
  then
    echo "dont forget to pass in a filter..."
    echo "usage: ./procmon.sh jason.sh" 
  else

# set the IFS to delimit results with correct spacing
IFS=$'\n'

# get current proccesses
baseline_proc=$(ps -eo command)

# pretty
echo "[*] Started listening for new proc's. Filter: $1"

# begin identifying any new spawned procs
while true; do
    current_proc=$(ps -eo command)
    diff <(echo "$baseline_proc") <(echo "$current_proc")| grep [\<\>] | grep $1
    sleep 1
    baseline_proc=$current_proc
done

fi
