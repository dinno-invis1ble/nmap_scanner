#! /usr/bin/bash

black="\033[30m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
white="\033[37m"
reset="\e[0m"

echo -e "Welcome, this is a simple nmap automation tool"
echo "<------------------------------------------------------>"

#echo "Please enter the IP address you want to scan: "
read -p "Please enter the IP address you want to scan: " ip_addr

echo "The IP you entered is: $ip_addr"

echo -e "\nPlease enter the type of scan you want to run" 
select resp in "SYN ACK Scan" "UDP Scan" "Comprehensive Scan"
do
   if [[ $resp != "SYN ACK Scan" && $resp != "UDP Scan" && $resp != "Comprehensive Scan" ]]
   then  echo "Please enter type..."
   else break
   fi
   #echo $resp
   #break
done

echo "You have selected option: "$resp

case $resp in
   "SYN ACK Scan") 
	echo;
	nmap --version | head -n1 ; 
	echo -e "\n"; 
	#nmap -v -sS $ip_addr -p 1-1024
	nmap -sS $ip_addr -p 1-1024 
        if ping -c 1 $ip_addr &> /dev/null
	then
		echo -e "\nIp Status: $green$ip_addr is UP$reset"
	else
		echo -e "\nIp Status: $red$ip_addr is DOWN$reset"
	fi
	echo ;;
   "UDP Scan")
	echo; 
	nmap --version | head -n1 ; 
	echo -e "\n"; 
	nmap -v -sU $ip_addr -p 1-1024 
#        nmap -sU $ip_addr -p 1-1024
	if ping -c 1 $ip_addr &> /dev/null
	then
		echo -e "\nIp Status: $green$ip_addr is UP$reset"
	else
		echo -e "\nIp Status: $green$ip_addr is DOWN$reset"
	fi
	echo ;;
   "Comprehensive Scan")
	echo; 
	nmap --version | head -n1 ; 
	echo -e "\n"; 
	nmap -v -sS -sV -sC -A -O $ip_addr -p 1-1024 
#        nmap -sS -sV -sC -A -O $ip_addr -p 1-1024
	if ping -c 1 $ip_addr &> /dev/null
	then
		echo -e "\nIp Status: $green$ip_addr is UP$reset"
	else
		echo -e "\nIp Status: $green$ip_addr is DOWN$reset"
	fi
	echo ;;
   *) echo "Invalid type" ;;
esac

