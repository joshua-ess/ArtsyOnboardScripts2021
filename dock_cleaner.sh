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
if [[ -d $chrome ]]
then
    ./dockutil --add "$chrome" --position 3 
fi

if [[ -d $drive ]]
then
    ./dockutil --add "$drive" --position 4 
fi

if [[ -d $slack ]]
then
    ./dockutil --add "$slack" --position 5
fi


if [[ -d $onepass ]]
then
    ./dockutil --add "$onepass" --position 6
fi

if [[ -d $zoom ]]
then
    ./dockutil --add "$zoom" --position 7 
fi

