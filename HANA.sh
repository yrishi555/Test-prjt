#!/bin/sh
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sdb
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number
    # default - start at beginning of disk 
  +50G # 50 GB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +150G # 150 GB boot parttion    
  n # new partition
  p # primary partition
  3 # partition number
    # default - start at beginning of disk
  +50G # 50 GB boot parttion
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

mkfs.ext4 /dev/sdb1 -F
mkfs.ext4 /dev/sdb2
mkfs.ext4 /dev/sdb3


mkdir -p /hana/shared
mkdir -p /hana/data/GSE
mkdir -p /hana/log/GSE

mount /dev/sdb1 /hana/shared
mount /dev/sdb2 /hana/data/GSE
mount /dev/sdb3 /hana/log/GSE

cd /hana/shared
mkdir software
mv  /root/51051151  /hana/shared/software/51051151

cd /hana/shared/software/51051151/DATA_UNITS/HDB_LCM_LINUX_X86_64/

(
echo 1 # For installing new system
echo 1,3,6 # For installing server,client,studio
echo   # Installation Path /hana/shared
echo   # Local Host Name [susesapvm]
echo   # No add additional hosts to the system
echo GSE # SAP HANA System ID
echo   # Instance Number [00]
echo 1 # Single container Database Mode
echo   # custom System Usage
echo   # Location of Data Volumes [/hana/data/GSE]
echo   # Location of Log Volumes [/hana/log/GSE]
echo   # Host Name For Host 'susesapvm' [susesapvm]
echo HP1nvent # SAP Host Agent User (sapadm) Password
echo HP1nvent # SAP Host Agent User (sapadm) Password:
echo HP1nvent # System Administrator (gseadm) Password:
echo HP1nvent # Confirm System Administrator (gseadm) Password
echo   # System Administrator Home Directory [/usr/sap/GSE/home]:
echo   # System Administrator Login Shell [/bin/sh]:
echo   # System Administrator User ID [1002]:
echo   # ID of User Group (sapsys) [79]:
echo HP1nvent   # Database User (SYSTEM) Password:
echo HP1nvent  #Confirm Database User (SYSTEM) Password:
echo   # Restart system after machine reboot? [n]
echo y # Do you want to continue? (y/n):
) | ./hdblcm

