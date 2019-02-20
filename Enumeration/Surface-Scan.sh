
#!/bin/bash

# pass in target address and port
if [ -z "$1" ]
  then
    echo "Please select scan host: Surface-Scan.sh somedomain.to.hax"
  else
    echo "[*] beggining Surface scan!"
    mkdir $1_ScanOutput
    nmap -p- -sV -sS -T4 -oA $1_ScanOutput/$1.txt $1

fi


