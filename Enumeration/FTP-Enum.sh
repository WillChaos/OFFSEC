#!/bin/bash
# standard FTP enumeration

if [ -z "$1" ]
  then
    echo "Please select IP"
  else
  
    # check Anon 
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Checking for anon auth "
    nmap --script ftp-anon.nse --script-args=unsafe=1 -p21 $1

    # checks for well know SMB vulnerabilities
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Checking for exploits and backdoors"
    for NSEScript in $(ls /usr/share/nmap/scripts/ | grep -e ftp-vuln -e backdoor)
	      do
		        echo "-[*] running $NSEScript"
		        nmap --script $NSEScript -script-args=unsafe=1 -p21 $1
	      done
            echo "-[*] checking ftp-libopie.nse"
            nmap --script ftp-libopie.nse -script-args=unsafe=1 -p21 $1
            

   
   
   # Runs nmap ftp enum
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Running FTP Enum, checking bounce and quering ftp-syst"
    nmap --script tftp-enum.nse, ftp-bounce.nse, ftp-syst.nse --script-args=unsafe=1 -p21 $1

  
fi
