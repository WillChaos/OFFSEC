!/bin/bash 

if [ $# -ne 1 ] 
    then
        echo "Please select scan host: DNS-Enum.sh <targetDomain> "
        echo "Example: ./DNS-Enum.sh somedomain.com "
    else
        # main
        echo "[------------- DNSEnum by WillChaos--------------]"

        echo "[*] Running DNS Recon against: $1"
        # gets current dir
       DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

       # recons DNS using list form adjacent dir
        dnsrecon -d $1 --threads 10
       echo " "
       echo "[*] Running DNSEnum against: $1"

       dnsenum $1 -f $DIR/../Wordlists/DNS/subdomains.txt --threads 10 -
 fi


