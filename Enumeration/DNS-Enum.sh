#!/bin/bash 

if [ $# -ne 1 ] 
    then
        echo "Please select scan host: DNS-Enum.sh <targetDomain> "
        echo "Example: ./DNS-Enum.sh somedomain.com "
    else
        # main
        echo "[------------- DNSEnum by WillChaos--------------]"

        echo "[*] Running DNS Enumeration against: $1"
        dnsrecon -d $1 -D ../Wordlists/DNS/subdomains.txt --threads 10

 fi
