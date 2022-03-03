#!/bin/bash
#the_file=https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil
#chrome=/Applications/Google Chrome.app
#drive=/Applications/Google Drive.app 
#slack=/Applications/Slack.app
#onepass=/Applications/1Password 7.app
#zoom=/Applications/zoom.us.app
#notion=/Applications/Notion.app
error_message="base artsy apps missing, please run: curl -L https://git.io/JG2F7 | bash"

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

# curl -O "$the_file"
chmod +x dockutil

# dockutil cleanups
# get rid of podcasts, appletv, facetime, messages, itunes
dockutil --remove 'Mail' ;
dockutil --remove 'Contacts' ;
dockutil --remove 'Calendar' ;
dockutil --remove 'Reminders' ;
dockutil --remove 'Maps' ;
dockutil --remove 'Messages' ;
dockutil --remove 'FaceTime' ;
dockutil --remove 'Music' ;
dockutil --remove 'Podcasts' ;
dockutil --remove 'TV' ;
dockutil --remove 'Pages' ;
dockutil --remove 'Numbers' ;
dockutil --remove 'Keynote' ;
dockutil --remove 'Safari' ;
dockutil --remove 'News' ;

# check for base apps and add them in
if [[ -d $zoom ]] && [[ -d $chrome ]] && [[ -d $drive ]] && [[ -d $slack ]] && [[ -d $onepass ]] && [[ -d $notion ]]
    then
        dockutil --add "/Applications/Google Chrome.app" --position 3 ;
        dockutil --add "/Applications/Google Drive" --position 4 ;
        dockutil --add "/Applications/Slack.app" --position 5 ;
        dockutil --add "/Applications/1Password 7.app" --position 6 ;
        dockutil --add "/Applications/zoom.us.app" --position 7 ;
        dockutil --add "/Applications/Notion.app" --position 8 ; 
    else
        echo
        echo "---"
        echo "$error_message"
        echo "---"
        echo
fi

