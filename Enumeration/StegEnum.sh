#!/bin/bash 

if [ $# -ne 1 ] 
    then
        echo "Please select target file: http://URL/file.jpg"
        echo "Example: ./StegEnum.sh http://10.10.10.x/file.jpg"
    else
        # main
        echo "[------------- StegEnum by WillChaos--------------]"
	echo "INFO: This script downloads file from a webserver and performs steg testing"

        echo "[*] ------------------Downloading Pic-----------------------"
        wget $1 -O imageFile

        echo "[*] -----------Dumping RAW Strings from image file----------"
        strings imageFile 

        echo "[*] --------------Dumping HEX from image file----------------"
        echo "[+] RAW hex"
        hexdump -C imageFile
        
        echo "[+] Checking for Hex values written past EOF marker"
        hexdump -C imageFile | more +/"ff d9"
       
	echo "[*] -----------Checking for hidden content / steg------------"
        echo "[+] using steghide info to check base details - use password if you have one"
        steghide info imageFile
        
        echo "[+] TODO: bruteforce steg pass "
        
 fi

