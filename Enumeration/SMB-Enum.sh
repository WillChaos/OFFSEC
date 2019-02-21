#!/bin/bash
# standard SMB enumeration

if [ -z "$1" ]
  then
    echo "Please select IP"
  else
  
    # check OS
    echo "[*] Enumerating OS version "
    nmap --script smb-os-discovery.nse --script-args=unsafe=1 -p445 $1
    
    # checks for null sessions
    echo "[*] Checking for null sessions... "
    smbmap -H $1
    
    # checks for shares via SMB
    echo "[*] Looking up share names..."
    nmap --script smb-enum-shares.nse --script-args=unsafe=1 -p445 $1
    
    # checks for users via SMB
    echo "[*] Looking up potential user names..."
    nmap --script smb-enum-users.nse --script-args=unsafe=1 -p445 $1
    
    # checks for MS08-067
    echo "[*] Checking exlusively for ms08-067"
    nmap --script smb-vuln-ms08-067.nse -p445
    
    # checks for MS17-010
    echo "[*] Checking exlusively for MS17-010"
    nmap -p 445 --script=smb-vuln-ms17-010.nse $1

    # checks for well know SMB vulnerabilities
    echo "[*] Checking for known easy to probe vulnerabilites"
    nmap --script smb-check-vulns.nse --script-args=unsafe=1 -p445 $1
    
    # Run enum4linux to get everything else including rid cycling etc
    echo "[*] Running enum4Linux to see what else we can find"
    enum4linux -v -a $1
    
    # check if Double pulsar backdoor is present
    echo "[*] Checking to see if target has a double pulsar backdoor present..."
    nmap -p 445 $1 --script=smb-double-pulsar-backdoor 
    
    echo "[*] and as a final step, simply setting up a brute force"
    nmap --script smb-brute.nse -p445 $1
fi

