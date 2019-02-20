#!/bin/bash

# pass in target address and port
if [ -z "$1" ]
  then
    echo "Please select scan host: Surface-Scan.sh somedomain.to.hax"
  else
    echo "[*] beggining Surface scan!"

    nmap -p- -sV -sS -T4 $1

fi


