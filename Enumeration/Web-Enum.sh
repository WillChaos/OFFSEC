#!/bin/bash 


if [ $# -ne 2 ] 
    then
        echo "Please select scan host: Web-enum.sh <targetIP>  <port>"
        echo "Example: ./Web-enum.sh 10.10.10.105 443"
    else
        # main
        echo "[------------- WebEnum by WillChaos--------------]"

        echo "[*] Running SSL Enumeration"
        sslscan --show-certificate --verbose $1:$2

        echo "[*] Running gobuster and outputing to > $1-$2.txt"
        gobuster -e -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt > $1-$2.txt &

        echo "[*] Running Nikto scan"
        nikto -host $1 -port $2

        echo "TODO: add CMS dection (and everything else really.. lehl)"
        # such ambition, not many reuslts, wow


 fi

