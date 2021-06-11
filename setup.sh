#!/bin/bash
# desc: setup accounts, apps, icons, wallpaper, dock, compname, brew
# meraki, filevault. last 2 still very wip, rest normal wip. 

# vars
user=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
directory=$HOME/.artsy
bold=$(tput bold)  # ${bold}
red=$(tput setaf 1) # ${red}
std=$(tput sgr0) # ${std}

# functions
printer () {
string=''$message''
for ((i=0; i<=${#string}; i++)); do
        printf '%s' "${string:$i:1}"
            sleep 0.$(( (RANDOM % 1) + 1 ))
        done 
printf -- '\n';
}

# clear

message="ok, lets get started with some passwords"
printer

# get the pass
echo 
echo -n "Enter Admin Password for $bold SUDO $std: "
read -r -s password

echo 
echo -n "Enter $bold Setup Password from IT Vault $std: "
read -r -s setup_password

# new idea - while loop in case of bad pass
while [[ ! -d "$directory" ]] 
    do
        echo 
        mkdir "$directory" 
        echo "mkdir $directory" 

   done
        echo 
        echo "$directory exists or was created!"
        echo 

cd $directory  || exit
echo "cd $directory" 
echo "should be in the proper dir: $(pwd)"
message="next to get the tricky sudo bits installed "
printer
echo
echo "go go curl magic!"
echo; echo

# sudo + input
# set default system accounts - prob
curl -LO https://git.io/JG2FK && chmod +x JG2FK && echo "$password" | sudo -S sh -c source JG2FK
echo; echo
echo "we should now have base accounts in place"
echo; echo

# set user icons
curl -LO https://git.io/JG2bZ && chmod +x JG2bZ && echo "$password" | sudo -S ./JG2bZ 
echo; echo
echo "said accounts better have a nice icon now as well"
echo; echo

# set compname
echo "lets fix the hostname on up..."
echo "cur name is: $(hostname)"
curl -LO https://git.io/JG2Fx && chmod +x JG2Fx && echo "$password" | sudo -S ./JG2Fx
echo; echo
echo "new name is: $(hostname)"
echo; echo

# no sudo 
# brew 1st - get apps in place
echo "${bold}brew${std} times..."
message="${bold}BREW WILL ASK FOR A LOT OF STUFF - PLEASE PAY ATTENTION ${red}NATHAN${std}"
printer
echo; echo
curl -L https://git.io/JG2F7 | bash
# set dock
echo "${bold}dock cleanup${std}"
message="${bold}ITS GUNNA BLINK A LOT ${red} ITS OK${std}"
printer
echo; echo
curl -L https://git.io/JGP8E | bash     
# set wallpaper
echo; echo
echo "simple wallpaper fix"
echo; echo
curl -L https://git.io/JGPNv | bash

osascript -e 'display notification "YOU GOTTA ENABLE FILEVAULT + MERAKI - script will now force a reboot"'
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

# make an info txt and pass it to my comp/gdrive
file=$directory/"$user"-macinfo.txt
touch "$file"
date > "$file"

echo "$(hostname)" >> "$file"
echo "$user" >> "$file"
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

# old munki block
# printf -- '--- Getting Munki ---\n';
# curl -O 10.135.10.131/munki.pkg
# sudo installer -allowUntrusted -pkg munki.pkg -target /
# sudo defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL "http://10.135.10.131/munki_repo"
# sudo /usr/local/munki/managedsoftwareupdate --show-config
# sudo /usr/local/munki/managedsoftwareupdate -a
# sudo /bin/bash -c "$(curl -s http://10.135.10.131/munkireport/index.php?/install)"
# sudo rm munki.pkg 

# meraki block

