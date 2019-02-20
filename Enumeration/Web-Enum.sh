#!/bin/bash

# Note , 80 and 443 are enumed by default - add custom shit in here later
# Note , Netcat required and callable using nc

# main
if [ -z "$1" ]
  then
    echo "Please select scan host: Web-enum.sh somedomainto.enum"
  else
  
    # build vars
    logdir = $1_WebScanOutput
    target = $1
    is80Open=$false
    is443Open=$false
    
    # functions
    VHost-Enum(){
      echo "[*] "
    }
    
    # main
    echo "[------------- WebEnum by WillChaos--------------]"
    
    echo "-[*] building log dir"
        # Create log file
        mkdir $logdir
        
    echo "-[*] Detecting ports"
        # checking port 80
        nc -z -v -w5 $target 80
        result1=$?

        if [  "$result1" != 0 ]; then
          echo  '-[!] port 80 is closed.'
          $is80Open=$false
        else
          echo '-[*] port 80 is open.'
          $is80Open=$true
        fi
        
        # checking port 443
        nc -z -v -w5 $target 443
        result1=$?

        if [  "$result1" != 0 ]; then
          echo  '-[!] port 443 is closed.'
          $is443Open=$false
        else
          echo '-[*] port 443 is open.'
          $is443Open=$true
        fi
        
        # -- in this section, if port 443 is open begin vhost scanning base don ssl grab - then move on to port 80 and 443 standard enums

fi
