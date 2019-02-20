#!/bin/bash

# pass in target address and port
if [ -z "$1" ]
  then
    echo "Please select destination host: Geo-Trace.sh someone.com 80"
  else
    echo "[*] beggining Geo trace - includes Geo lookup and Port checking "
    echo "[*] targetting: $1 $2"

    sudo nmap --traceroute --script traceroute-geolocation.nse -p $2 $1

fi
