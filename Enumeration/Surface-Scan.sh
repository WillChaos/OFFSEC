#!/bin/bash

# pass in target address and port
if [ -z "$1" ]
  then
    echo "Please select scan host: Surface-Scan.sh somedomain.to.hax (note: all output is saved to textfile also)"
  else
    echo "[*] Beggining Surface scan! - all tcp ports will be checked"
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    mkdir $1_ScanOutput
    nmap -p- -sV -sS -T4 -oA $1_ScanOutput/$1.txt $1
    echo "-[+] Converting output to HTML readable..."
    xsltproc $1_ScanOutput/$1.txt.xml -o $1_ScanOutput/$1.html
    echo "-[+] Opening HTML Nmap Scan..."
    firefox $1_ScanOutput/$1.html &
    echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    echo "[*] Running a FULL UDP scan a - check back soon"
    nmap -p-  -sU -T4 -oA $1_ScanOutput/$1.udp.txt $1


fi


