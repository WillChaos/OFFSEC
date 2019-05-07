####################################################################################################
#
#                                           - Dexxies -
#                             A Script built to automatate enumeration
#                                 Built to taget OSCP/HTB machines
#
#
#
####################################################################################################

# imports
import sys

# vars / globals
db_targetip  = None
db_ports     = None
db_users     = None
db_locations = None
db_loot      = None

# functions
def main_banner():
	print("[+]-------------------------------------------------------------------------------[+]")
	print("[+]>                            Dexxies by WillChaos                             <[+]")
	print("[+]_                          _ ______________ _                                 _[+]")
	print(" +  _____________________________________________________________________________  + ")
	print("                                                                                      ")

def proggy_banner():
	print("[|----------------------------------------------------------------------------------|]")
	print("[|                              Dexxies - Enumerator                                |]")
	print("[|----------------------------------------------------------------------------------|]")
	print(" |  Ports /Services    |   Users / passwords    |   locations       |    loot       | ")
	print(" |``````````````````````````````````````````````````````````````````````````````````| ")
	print(" |__________________________________________________________________________________| ")


def user_console():
	print(" ")
	console_resp = input("(|DEXXIES||>")
	if console_resp == "help":
		print("[*] Selected Help menu!")
		print(" ~ help : shows this menu")
		print(" ~ db   : preview current database")
		print(" ~ s    : view current scanner progress")
		print(" ~ fsu  : fsu (fuck shit up) is used to begin targetting an attack")
		user_console()

	if console_resp == "db":
		print("[*] Checking DB for updates!")
		user_console()

	if console_resp == "s":
		print("[*] Checking raw scanner progress...")
		user_console()

	if console_resp == "fsu":
		print("[*] FSU has been requessting, beggining enumeration")
		db_targetip = input("-[?] Select IP > ")
		print("-[!] Target IP: " + str(db_targetip))
		user_console()

	else :
		user_console()
# main
main_banner()
user_console()