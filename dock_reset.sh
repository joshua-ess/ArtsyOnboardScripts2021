#!/bin/bash

directory=/tmp
the_file=https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil
chrome=/Applications/Google\ Chrome.app
drive=/Applications/Google\ Drive.app 
slack=/Applications/Slack.app
onepass=/Applications/1Password\ 7.app/
zoom=/Applications/zoom.us.app

# funcs
printer () {
string=''$message''
for ((i=0; i<=${#string}; i++)); do
        printf '%s' "${string:$i:1}"
            sleep 0.$(( (RANDOM % 1) + 1 ))
        done 
printf -- '\n';
}

    clear
    printf -- 'auto dock clean up now \n';
    message='it will blink a lot --- it is OK'
    printer
    echo

cd "$directory" || exit
curl -O "$the_file"
chmod +x dockutil

# dockutil cleanups
./dockutil --add 'Mail' ;
./dockutil --add 'Contacts' ;
./dockutil --add 'Calendar' ;
./dockutil --add 'Reminders' ;
./dockutil --add 'Maps' ;
./dockutil --add 'Messages' ;
./dockutil --add 'FaceTime' ;
./dockutil --add 'Music' ;
./dockutil --add 'Podcasts' ;
./dockutil --add 'TV' ;
./dockutil --add 'Pages' ;
./dockutil --add 'Numbers' ;
./dockutil --add 'Keynote' ;
./dockutil --add 'Safari' ;

./dockutil --remove "$chrome" 
./dockutil --remove "$drive" 
./dockutil --remove "$slack" 
./dockutil --remove "$onepass"
./dockutil --remove "$zoom" 













./dockutil --add /Applications/Google\ Drive.app --position 4 ;
./dockutil --add /Applications/Slack.app --position 5 ;
./dockutil --add /Applications/1Password\ 7.app/ --position 6 ;
./dockutil --add /Applications/zoom.us.app --position 7 ;

