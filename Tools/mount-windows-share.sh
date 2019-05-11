#!/bin/bash

########################################################################
#                     Simply mounts SMB share to /mnt/x
#                                :)-/-<
#########################################################################

mkdir /mnt/x
mount -t cifs //10.10.10.x/Backups/ /mnt/x -o username=WORKGROUP/guest
