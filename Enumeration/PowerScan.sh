#!/bin/bash

#===============================================================================================#
#_______________________________________________________________________________________________#
#                                        PowerScan by WillChaos                                 #
#                                                  v0.7                                         #
#                       Built to Autoate initial enum via portscans and standard enums          #
#  Reqs:                                                                                        #
#  $ sudo apt-get install git gcc make libpcap-dev                                              #
#  $ git clone https://github.com/robertdavidgraham/masscan                                     #
#  $ cd masscan                                                                                 #
#  $ make                                                                                       #
#_______________________________________________________________________________________________#
#===============================================================================================#

# ----------------------------------------   vars    -------------------------------------------#
targets=( "$@" )
target_counter=${#targets[@]}

# ---------------------------------------- Functions -------------------------------------------#
function invoke_banner(){
	echo "[+]----------------------------------------------------------------------------[+]"
        echo "[|]                     PowerScan by WillChaos - 0.7                           [|] "
        echo "[+]----------------------------------------------------------------------------[+]"
}

function build_directory(){
	if [ -d "$1" ]; then
  		echo "[!] $1 directory already exists, we will use this."
	else
		echo "[*] Building Dir: $1/"
		mkdir $1
	fi

}

function invoke_tcpscan(){
	echo "[*] Begining masscan to return openTCP ports [rate 10,000]"
	masscan $1 -p0-65535 --max-rate 10000 -e tun0 -oX "$1/masscan_port_enumeration.xml"
}

# ----------------------------------------    Exec   -------------------------------------------#

if [ $# -lt 1 ] 
    then
        echo "___________________________________________________________"
        echo "Pass in all ips you wish to scan                           "
        echo "Example: ./PowerScan 10.10.10.105 10.10.10.222 10.10.10.x  "
        echo "___________________________________________________________"
    else
	# foreach IP Passed into the script
	for (( i=1; i<${target_counter}+1; i++ ));
	do
		current_target=${targets[$i-1]}
   		echo "[*] Targeting: $current_target"

		# build a working directory for the scan results
		build_directory "$current_target"

		# begin masscan
		invoke_tcpscan "$current_target"
	done
fi
