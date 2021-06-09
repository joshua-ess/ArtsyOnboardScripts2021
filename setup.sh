#!/bin/bash
# desc: setup accounts, apps, icons, wallpaper, dock, compname, brew
# meraki, filevault. last 2 still very wip, rest normal wip. 

# vars
directory=/tmp

# ok this script prob a curl, chmod, and ./ case. 

# sudo + input
# set default system accounts
curl -LO https://git.io/JG2FK && chmod +x JG2FK && sudo ./JG2FK
# set user icons
curl -LO https://git.io/JG2bZ && chmod +x JG2bZ && sudo ./JG2bZ 
# sudo
# set compname
curl -L https://git.io/JG2Fx | sudo bash

# no sudo 
# brew
curl -L https://git.io/JG2F7 | bash
# set dock
curl -L https://git.io/JGP8E | bash     
# set wallpaper
curl -L https://git.io/JGPNv | bash

# func
printer () {
string=''$message''
for ((i=0; i<=${#string}; i++)); do
        printf '%s' "${string:$i:1}"
            sleep 0.$(( (RANDOM % 1) + 1 ))
        done 
printf -- '\n';
}

# example of func usage
#    clear
#    printf -- 'time for the vault...'
#    message='GO!   '
#    printer
#    echo

# set the vault up -- double check me
# read -r -s -p "Enter Password for the '$user' Account: " userpass
# printf -- '\n';
# # read -r -s -p "Enter Password for Admin: " adminpass
# # printf -- '\n';
# fdesetup status
# 
# sudo fdesetup enable
# sudo sysadminctl -adminUser "$user" -adminPassword "$userpass" -secureTokenOn admin -password "$adminpass"
# sudo sysadminctl -adminUser "$user" -adminPassword "$userpass" -secureTokenOn "$user" -password "$userpass"
# sudo fdesetup add -user "$user" -usertoadd admin 
# sudo fdesetup add -user "$user" -usertoadd "$user"
# fdesetup status

    clear
    printf -- '!! meraki time !!'
    printf -- 'meraki code should be on the clipboard'
    message='be ready for chrome 1st run'
    printer
    echo

 # meraki block
merakiurl='https://m.meraki.com/enroll?id=169-312-5055'
meraki_id=169-312-5055
echo $meraki_id | pbcopy
open -a "Google Chrome" "$merakiurl" 

# open -a "Safari" "$merakiurl" 
# osascript -e 'display notification "Script paused until profile is downloaded" with title "Meraki Profile Alert"'
# osascript -e 'display notification "Please install the profile from Meraki "'
# printf -- '--- Please install the profile from Meraki ---\n';
# osascript -e 'display notification "Set Chrome as default browser and close the extra window please" with title "Set Chrome as Default"'
         while [ ! -f "$HOME"/Downloads/meraki_sm_mdm.mobileconfig  ]
                 do
                   sleep 1s 
# 		  echo "please download & install meraki profile from Chrome..."
                 done
# sleep 5s
# # does not work -- mac seems to require a button push...
# # sudo killall -9 "Google Chrome"
# # sleep 3s

sudo /usr/bin/profiles -P
sudo /usr/bin/profiles -I -F "$HOME"/Downloads/meraki_sm_mdm.mobileconfig 
sudo cp "$HOME"/Downloads/meraki_sm_mdm.mobileconfig $directory
sudo /usr/bin/profiles -P

    clear
    printf -- 'creating hardware report'
    # message='now'
    # printer
    echo

# make an info txt and pass it to my comp/gdrive
file=$directory/"$user"-macinfo.txt
touch "$file"
date > "$file"

echo "$HOSTNAME" >> "$file"
echo "$USER" >> "$file"
fdesetup status >> "$file"
system_profiler SPHardwareDataType >> "$file"

# scp "$file" nathan@njh-pc-mba.local:~/Documents/my_drive/hardware/
# with a server and a pass we could dump the files into place
# then gam could snag them up and pass them on

# remove my home net -- NEEDS WORK
wservice=$(/usr/sbin/networksetup -listallnetworkservices | grep -Ei '(Wi-Fi|AirPort)')
device=$(/usr/sbin/networksetup -listallhardwareports | awk "/$wservice/,/Ethernet Address/" | awk 'NR==2' | cut -d " " -f 2)
networksetup -removepreferredwirelessnetwork "$device" "PYUR 97094"

# destroy thine self
sudo softwareupdate -i -a -R 
sudo reboot
rm -- "$0"

# notes / potential code
# get passwords
# read -r -s -p  "Enter Password for $user : " userpass
# printf -- '\n';
# read -r -s -p  "Enter Password for new Admin account, be very sure of it : " adminpass
# printf -- '\n';

# my old MUNKI block
# printf -- '--- Getting Munki ---\n';
# curl -O 10.135.10.131/munki.pkg
# sudo installer -allowUntrusted -pkg munki.pkg -target /
# sudo defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL "http://10.135.10.131/munki_repo"
# sudo /usr/local/munki/managedsoftwareupdate --show-config
# sudo /usr/local/munki/managedsoftwareupdate -a
# sudo /bin/bash -c "$(curl -s http://10.135.10.131/munkireport/index.php?/install)"
# sudo rm munki.pkg 

# meraki block
#merakiurl='https://m.meraki.com/enroll?id=169-312-5055'
#meraki_id=169-312-5055
# 
#echo $meraki_id | pbcopy
#open -a "Google Chrome" "$merakiurl" 
# open -a "Safari" "$merakiurl" 
# osascript -e 'display notification "Script paused until profile is downloaded" with title "Meraki Profile Alert"'
# osascript -e 'display notification "Please install the profile from Meraki "'
# printf -- '--- Please install the profile from Meraki ---\n';
# osascript -e 'display notification "Set Chrome as default browser and close the extra window please" with title "Set Chrome as Default"'
#         while [ ! -f "$HOME"/Downloads/meraki_sm_mdm.mobileconfig  ]
#                 do
#                   sleep 1s 
# 		  echo "please download & install meraki profile from Chrome..."
#                 done
# sleep 5s
# # does not work -- mac seems to require a button push...
# # sudo killall -9 "Google Chrome"
# # sleep 3s
# # sudo /usr/bin/profiles -P
# # sudo /usr/bin/profiles -I -F "$HOME"/Downloads/meraki_sm_mdm.mobileconfig 
# sudo cp "$HOME"/Downloads/meraki_sm_mdm.mobileconfig $directory
# # sudo /usr/bin/profiles -P

