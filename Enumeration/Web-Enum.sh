#!/bin/bash 

##############################################################################################################
#
# Description: Some hella simple web checks i always run. 
#              nothing fancy, and a bit of a dodgie homejob script!
# Author:      WillChaos
# Usage:       Example: ./Web-enum.sh x.x.x.x 443
#############################################################################################################



# ------------------------------------------------ Functions -------------------------------------------------

# if `validate_url $url >/dev/null`; then dosomething; else echo "does not exist"; fi
# cred: https://gist.github.com/hrwgc/7455343
function validate_url(){
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then echo "true"; fi
}

# -------------------------------------------------- Exec ----------------------------------------------------
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
        nmap $1 -p $2 --scrip=http-auth-finder.nse -Pn > $1-$2-AUTHSPIDER.txt &

        echo "[*] Running gobuster and outputing to > $1-$2.txt - backgrounded job"
        gobuster -e -u $1:$2 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -o $1-$2-GOBUSTER.txt &
        
        echo "[*] Checking if wordpress exists..."
        if [ validate_url $1:$2/wp-login.php >/dev/null] 
        then
            echo "[!] Found wordpress indicated by login page here: $1:$2/wp-login.php"
            echo "[!] Running backgrounded wpscan"
            wpscan --url $1:$2--enumerate vp, vt, cb ,u -t 10 --output wordpress-$1:$2-wp.txt  --force --update --random-user-agent &
            
        else
            if [ validate_url $1:$2/wp/wp-login.php >/dev/null]
                echo "[!] Found wordpress indicated by login page here: $1:$2/wp/wp-login.php"
                echo "[!] Running backgrounded wpscan"
                wpscan --url $1:$2/wp --enumerate vp, vt, cb ,u -t 10 --output wordpress-$1:$2-wp.txt --force --update --random-user-agent &
            else
                echo "[X] Wordpress not detected
            fi
        fi

        echo "[*] Running Nikto scan"
        nikto -host $1 -port $2

        


 fi

