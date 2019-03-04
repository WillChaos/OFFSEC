#!/bin/bash

if [ -z "$1" ]
  then
    echo "usage: ncPortScan.sh <target>"
    echo "example: ./ncPortScan.sh 192.168.10.105"
  else

# scans 4444 ports.
echo "[*] Scanning 20-30 common ports"
nc -v -z -n -w 1 $1 21 
nc -v -z -n -w 1 $1 22
nc -v -z -n -w 1 $1 23
nc -v -z -n -w 1 $1 25
nc -v -z -n -w 1 $1 53
nc -v -z -n -w 1 $1 67
nc -v -z -n -w 1 $1 68
nc -v -z -n -w 1 $1 69
nc -v -z -n -w 1 $1 80
nc -v -z -n -w 1 $1 81
nc -v -z -n -w 1 $1 110
nc -v -z -n -w 1 $1 123
nc -v -z -n -w 1 $1 139
nc -v -z -n -w 1 $1 143
nc -u -v -z -n -w 1 $1 161
nc -v -z -n -w 1 $1 389
nc -v -z -n -w 1 $1 636
nc -v -z -n -w 1 $1 990
nc -v -z -n -w 1 $1 1023
nc -v -z -n -w 1 $1 1080
nc -v -z -n -w 1 $1 1337
nc -v -z -n -w 1 $1 3306
nc -v -z -n -w 1 $1 1701
nc -v -z -n -w 1 $1 1723
nc -v -z -n -w 1 $1 8080
nc -v -z -n -w 1 $1 443
nc -v -z -n -w 1 $1 4444
nc -v -z -n -w 1 $1 587
nc -v -z -n -w 1 $1 3389
nc -v -z -n -w 1 $1 9100
nc -v -z -n -w 1 $1 5502
nc -v -z -n -w 1 $1 2082
nc -v -z -n -w 1 $1 2083
nc -v -z -n -w 1 $1 2086
nc -v -z -n -w 1 $1 2087
nc -v -z -n -w 1 $1 2222
nc -v -z -n -w 1 $1 8888
nc -v -z -n -w 1 $1 9000
nc -v -z -n -w 1 $1 10000
nc -v -z -n -w 1 $1 20000

fi
