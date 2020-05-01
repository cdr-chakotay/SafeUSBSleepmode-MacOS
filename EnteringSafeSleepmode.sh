#!/bin/bash
read -p "Do you want to unmount and eject external drives and hibbernate? (y/n)" var1

var1=`echo $var1 | tr '[:upper:]' '[:lower:]'`

if [ $var1 = "y" ] || [ $var1 = "n" ] || [ $var1 = "j" ]
then
echo ""
else
echo "Wrong input .... please type (y)es or (n)o .... stopping the program"
sleep 3
exit 1
fi

if [ $var1 = "n" ]
then
echo "Stopping Process"
sleep 3
exit 0
fi

echo " Unmounting Disks ...."

countdrives=`diskutil list | grep -c "/disk"`

#usallay two paritions in use

if [ $countdrives -gt 3 ]
then
  #Mac has /disk0 and /disk1 in use. Counting starts at Zero.... -1 corrects the factor for loop
  let countdrives=countdrives-1

#Building realistic number for output (-1)
  tounmount=$countdrives
  let tounmount=tounmount-1

  echo "$tounmount Volumes to unmount ..."

  while [ $countdrives -gt 1 ]
  do
  diskutil unmountDisk /dev/disk$countdrives
  let countdrives=countdrives-1
  done
fi

#eject Drives -> Pretty much same procedure as above

edrives=`diskutil list | grep -c "/disk"`

if [ $edrives -gt 3 ]
then
  #realistic numbers
  let edrives=edrives-1
  let toeject=edrives-1
  echo "$toeject Volumes to eject ..."

  while [ $edrives -gt 1 ]
  do
  diskutil eject /dev/disk$edrives
  let edrives=edrives-1
  done
fi

echo "Unmounting and ejecting of drives complete"
sleep 1

echo "Entering sleepmode.... "
sleep 2
pmset sleepnow

exit 0
