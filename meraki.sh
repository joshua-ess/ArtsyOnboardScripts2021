#!/bin/bash
# vars
merakiurl='https://m.meraki.com/enroll?id=169-312-5055'

# func
printer () {
string=''$message''
for ((i=0; i<=${#string}; i++)); do
        printf '%s' "${string:$i:1}"
            sleep 0.$(( (RANDOM % 1) + 1 ))
        done 
printf -- '\n';
}
    clear
    printf -- '!! meraki time !!'
    printf -- 'meraki code should be on the clipboard'
    message='be ready for chrome 1st run'
    printer
    echo

open -a "Google Chrome" "$merakiurl" 

     while [ ! -f "$HOME"/Downloads/meraki_sm_mdm.mobileconfig  ]
             do
               sleep 1s 
               #echo "please download & install meraki profile from Chrome..."
             done

open -b com.apple.systempreferences /System/Library/PreferencePanes/Profiles.prefPane
