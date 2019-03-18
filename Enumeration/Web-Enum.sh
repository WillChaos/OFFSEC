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
        
        echo "[*] Checking user agent for browser filtering"
        nmap $1 -p $2 --script=http-useragent-tester.nse -Pn
        
        echo "[*] Running a basic default vhost sweep"
        nmap $1 -p $2 --script=http-vhosts.nse -Pn
        
        echo "[*] Checking for robots.txt"
        nmap $1 -p $2 --script=http-robots.txt.nse -Pn
        
        echo "[*] Running RFI/LFI spider - backgrounded job"
        nmap $1 -p $2 --script=http-rfi-spider.nse -Pn > $1-$2-RFISPIDER.txt &
        
        echo "[*] Running .GIt lookup"
        nmap $1 -p $2 --script=http-git.nse -Pn
        
        echo "[*] Running a spider to find auth page - backgrounded job"
        namp $1 -p $2 --scrip=http-auth-finder.nse -Pn > $1-$2-AUTHSPIDER.txt &

     
        echo "[*] Running gobuster and outputing to > $1-$2.txt - backgrounded job"
        gobuster -e -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt > $1-$2-GOBUSTER.txt &

        echo "[*] Running Nikto scan"
        nikto -host $1 -port $2

        echo "[!]TODO: add CMS dection (and everything else really.. lehl)"
        # such ambition, not many reuslts, wow


 fi

