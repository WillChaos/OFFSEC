#!/bin/bash

#####################################################################################################
#                                    Mounts windows VHD files 
#                                            =*)-/-<
#####################################################################################################
# requires: sudo apt-get install libguestfs-tools
# info:     https://stackoverflow.com/questions/36819474/how-can-i-attach-a-vhdx-or-vhd-file-in-linux
#####################################################################################################

mkdir /mnt/y
guestmount --add vhdlocation.vhd--inspector --ro /mnt/y
