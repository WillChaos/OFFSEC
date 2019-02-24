#!/bin/bash
# standard SMB enumeration

if [ -z "$1" ]
  then
    echo "Please select IP"
  else
  
    # check OS
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Enumerating OS version "
    nmap --script smb-os-discovery.nse --script-args=unsafe=1 -p445 $1
    

    # checks for null sessions
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Checking for null sessions... "
    smbmap -H $1
    

    # checks for shares via SMB
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Looking up share names..."
    nmap --script smb-enum-shares.nse --script-args=unsafe=1 -p445 $1
    
    # checks for users via SMB
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Looking up potential user names..."
    nmap --script smb-enum-users.nse --script-args=unsafe=1 -p445 $1

    # checks for well know SMB vulnerabilities
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Checking for known easy to probe vulnerabilites"
    for NSEScript in $(ls /usr/share/nmap/scripts/ | grep smb-vuln)
	      do
		        echo "-[*] running $NSEScript"
		        nmap --script $NSEScript -script-args=unsafe=1 -p445 $1
	      done
    
    
    # Run enum4linux to get everything else including rid cycling etc
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Running enum4Linux to see what else we can find"
    enum4linux -v -a $1
    
    # check if Double pulsar backdoor is present
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] Checking to see if target has a double pulsar backdoor present..."
    nmap -p 445 $1 --script=smb-double-pulsar-backdoor 
    
    # brute - and pass to SMB-PSexec 
    echo " "
    echo " "
    echo "===================================================================== "
    echo "[*] and as a final step, simply setting up a brute force"
    nmap -p139,445 --script=smb-brute,smb-psexec $1
fi
