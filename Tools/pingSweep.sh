#!/bin/bash

# simple ping sweeper - built for shell'd machines that we cant ssh tunnel to

if [ -z "$1" ]
  then
  echo "Usage: pingSweeper.sh <subnet>"
  echo "example: ./pingSweeper.sh 10.10.10.0"
else

# format input string
octet="$(echo "$1" | awk -F'.' '{print $1,$2,$3}' OFS='.')"

echo "[*] targetting network: $octet.0/24"

#  some magic shit 
for i in `seq 254`; 
  do 
 ping -c1 -w1 $octet.$i &> /dev/null && arp -n | awk ' /'$octet'.'$i' / { print "-[!]" $1 " " $3 } '
 done; 


fi
