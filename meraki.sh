#!/bin/bash
# vars
merakiurl='https://m.meraki.com/enroll?id=169-312-5055'
meraki_id=169-312-5055
directory=/tmp

# func
printer () {
string=''$message''
for ((i=0; i<=${#string}; i++)); do
        printf '%s' "${string:$i:1}"
            sleep 0.$(( (RANDOM % 1) + 1 ))
        done 
printf -- '\n';
}

echo $meraki_id | pbcopy

    clear
    printf -- '!! meraki time !!'
    printf -- 'meraki code should be on the clipboard'
    message='be ready for chrome 1st run'
    printer
    echo

open -a "Google Chrome" "$merakiurl" 

# open -a "Safari" "$merakiurl" 
# osascript -e 'display notification "Script paused until profile is downloaded" with title "Meraki Profile Alert"'
# osascript -e 'display notification "Please install the profile from Meraki "'
# printf -- '--- Please install the profile from Meraki ---\n';
# osascript -e 'display notification "Set Chrome as default browser and close the extra window please" with title "Set Chrome as Default"'

     while [ ! -f "$HOME"/Downloads/meraki_sm_mdm.mobileconfig  ]
             do
               sleep 1s 
               echo "please download & install meraki profile from Chrome..."
             done

# sleep 5s
# # does not work -- mac seems to require a button push...
# # sudo killall -9 "Google Chrome"
# # sleep 3s

printf -- 'lets see what profiles we have'
sudo /usr/bin/profiles -P
printf -- 'installing meraki profile hopefully...'
sudo /usr/bin/profiles -I -F "$HOME"/Downloads/meraki_sm_mdm.mobileconfig 
sudo cp "$HOME"/Downloads/meraki_sm_mdm.mobileconfig $directory
printf -- 'lets check them profiles again'
sudo /usr/bin/profiles -P

