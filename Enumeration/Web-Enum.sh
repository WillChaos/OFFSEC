#!/bin/bash

#Note , 80 and 443 are enumed by default - add custom shit in here later
#Note , Netcat required and callable using nc main

if [ -z "$1" ]
    then
        echo "Please select scan host: Web-enum.sh somedomainto.enum"
    else
        # main
        echo "[------------- WebEnum by WillChaos--------------]"
        echo "-[*] building log dir"
        mkdir $1-WebScanOutput target
        echo "[*] checking if SANS exist on SSL Certificate"
        openssl s_client -connect $1:443 | openssl x509 -noout -text | grep DNS:
        
        echo "[*] enumerating Virtual hosts"
        nmap -p 80,443 --script hostmap-bfk.nse $1 

 fi
