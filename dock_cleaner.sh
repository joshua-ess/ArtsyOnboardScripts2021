#!/bin/bash

directory=/tmp
the_file=https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil

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
./dockutil --remove 'Mail' ;
./dockutil --remove 'Contacts' ;
./dockutil --remove 'Calendar' ;
./dockutil --remove 'Reminders' ;
./dockutil --remove 'Maps' ;
./dockutil --remove 'Messages' ;
./dockutil --remove 'FaceTime' ;
./dockutil --remove 'Music' ;
./dockutil --remove 'Podcasts' ;
./dockutil --remove 'TV' ;
./dockutil --remove 'Pages' ;
./dockutil --remove 'Numbers' ;
./dockutil --remove 'Keynote' ;
./dockutil --remove 'Safari' ;
# get rid of podcasts, appletv, facetime, messages, itunes
./dockutil --add /Applications/Google\ Chrome.app --position 3 ;
./dockutil --add /Applications/Google\ Drive.app --position 4 ;
./dockutil --add /Applications/Slack.app --position 5 ;
./dockutil --add /Applications/1Password\ 7.app/ --position 6 ;
./dockutil --add /Applications/zoom.us.app --position 7 ;

