#!/bin/bash

############################################################################################################
#          Super hack'n'slash script to quickly stage working enviornment on a new kali install
#                                simply will be added to as time goes on.
###########################################################################################################

# Term prefs
echo "[*] Setting terminal prefs"

terminal_prefs='export PS1="\[\033[38;5;153m\]\u\[$(tput sgr0)\]\[\033[38;5;238m\]@\[$(tput sgr0)\]\[\033[38;5;158m\]\h\[$(tput sgr0)\]\[\033[38;5;236m\]:\[$(tput sgr0)\]\[\033[38;5;153m\]\w\[$(tput sgr0)\]\[\033[38;5;122m\]>\[$(tput sgr0)\]"'

if grep -Fxq "# Added by WillChaos" ~/.bashrc
    then
        echo "-[!] terminal prefs looks to have already been configured, Skipping"

    else
         echo " " >> ~/.bashrc
         echo "# Added by WillChaos" >> ~/.bashrc
         echo $terminal_prefs >> ~/.bashrc
         echo " " >> ~/.bashrc
         echo "-[+] Completed!"   
 fi


# Handling vmware tools restarts (usually fixes vmwar eversions of copy paste failers etc)
echo "-[*] Applying vmware tools fix"

vmwaretools_bashrc="

# vmware_tools fix
systemctl stop run-vmblock\\x2dfuse.mount
killall -q -w vmtoolsd

systemctl start run-vmblock\\x2dfuse.mount
systemctl enable run-vmblock\\x2dfuse.mount

vmware-user-suid-wrapper vmtoolsd -n vmusr 2>/dev/null
vmtoolsd -b /var/run/vmroot 2>/dev/null

vmware-users
"

if grep -Fxq "# vmware_tools fix" ~/.bashrc
    then
        echo "-[!] VMWareTools Fix allready applied, Skipping"

    else
         echo " " >> ~/.bashrc
         echo $vmwaretools_bashrc >> ~/.bashrc
         echo " " >> ~/.bashrc
         echo "-[+] Completed!"   
 fi


# Dependancies
echo "[*] installing dependancies and pre reqs for scripts and apps"
sudo apt-get install git gcc python-pip python3-pip make libpcap-dev 

# GIT clone for OFFSEC scripts
echo "[*] Staging OFFSEC working directory from GIT"
if [ ! -d "/opt/OFFSEC" ]
    then
        git clone https://github.com/WillChaos/OFFSEC.git /opt/OFFSEC
        echo "-[+] Staged"  
    else
        echo "-[!] Dir already exists, Skipping" 
fi

# software installs
echo "[*] Downloading and Staging masscan"
if [ ! -d "/opt/masscan" ]
    then
        git clone https://github.com/robertdavidgraham/masscan /opt/masscan && cd /opt/masscan && make
        echo "-[+] Staged"
    else
        echo "-[!] Dir already exists, Skipping"
fi

echo "[*] Installing Impacket"
if [ ! -d "/opt/impacket" ]
    then
        echo "-[+] Staged"
        git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket && cd /opt/impacket && pip install .
    else
        echo "-[!] Dir already exists, Skipping"
fi


# set background
echo "[*] setting background"
wget https://images.hdqwalls.com/wallpapers/mr-robot-mask-f-society-artwork-4k-on.jpg -O /root/Pictures/bg.jpg
gsettings set org.gnome.desktop.background picture-uri "file:///root/Pictures/bg.jpg"

# remove shit from the desktop
echo "[*] Stripping shit from the root desktop"
rm -rf /root/Desktop/*.*

# Updates
echo "[*] Running updates"
sudo apt-get update && apt-get upgrade 
