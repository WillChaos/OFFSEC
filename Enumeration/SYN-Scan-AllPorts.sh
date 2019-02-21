#!/bin/bash

# pass in target address and port
if [ -z "$1" ]
  then
    echo "Please select scan host: SYN-Scan-ALLPorts.sh somedomain.to.hax"
  else
    echo "[*] beggining fast SYN  scan - this method works well to quickly determine open - but provides little service info"
    mkdir $1_SYNSCANOUTPUT
    nmap -p-  -sS -T4 -oA $1_SYNSCANOUTPUT/$1.txt $1

fi
