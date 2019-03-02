if [ $# -ne 4 ]; then
    echo "Usage: ./SNMP.Enum.sh <IP> <port> <community string> <SNMPVersion>"
    echo "string info: use public if none other is known - this script will bruteforce at the end"
    echo "Example: ./SNMP-Enum.sh 10.10.10.105 161 public 3"
    exit 1
fi

# if targeting SNMP version 3 - then standard enum is not going to be applicable here.
# custom handler for snmp v3

if [ $4 = "3" ]; then
    echo " [========================= Enumerating & Attacking SNMPv3 Service ==========================]s"
    echo " [*] Simple Nmap query to qualify version if possible"
    nmap -sU -sV -p $2 $1

    echo " "
    echo "[*] Begging SNMP v3 Uname, Password, and encryption type brute force methods "
    # write host into host file, then use it as a target
    $1 > /usr/share/snmpwn/hosts.txt
    /usr/share/snmpwn/snmpwn.rb --hosts /usr/share/snmpwn/hosts.txt --users  /usr/share/snmpwn/users.txt --passlist /usr/share/snmpwn/passwords.txt --enclist /usr/share/snmpwn/passwords.txt

    echo "example: snmpwalk -v3  -l authPriv -u snmp-poller -a SHA -A "PASSWORD1"  -x AES -X "PASSWORD1" 10.10.60.50"
    exit 1
fi


# if this executes its less then version 3 - standard enum applies

echo "[==== Enumerating SNMP services on $1:$2 using a $3 string - SNMP VER $4 ====]"

echo "[*] simple nmap Service check"
    nmap -sU -sV -p $2 $1

echo "[*] Brute forcing community strings with onesixtyone"
    onesixtyone -c /usr/share/doc/onesixtyone/dict.txt $1


echo "[*] polling with SNMP-CHECK"
    snmp-check $1 -p $2 -c $3 -w

echo "[*] Walking through MIB tree using SNMP-WALK"
     snmpwalk -c $3 -v$4 $1

echo "[*] TODO: Detect MIB version if possible"

echo "[*] Running all NMAP SNMP Enumeration scripts available"
    for NSEScript in $(ls /usr/share/nmap/scripts/ | grep snmp)
        do
            echo "-[*] running $NSEScript"
            nmap -sU --script $NSEScript -script-args=unsafe=1 -p$2 $1
        done



