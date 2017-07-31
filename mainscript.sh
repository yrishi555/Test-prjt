#!/bin/sh
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sdb
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number
    # default - start at beginning of disk 
  +20G # 100 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +20G # 100 MB boot parttion    
  n # new partition
  p # primary partition
  3 # partition number
    # default - start at beginning of disk
  +9G # 100 MB boot parttion
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF
