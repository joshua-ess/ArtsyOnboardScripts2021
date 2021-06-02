#!/bin/bash
# vars
directory=/opt/artsy
url=https://github.com/jasonarias/2021onboarding/blob/main/
serial=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')
user=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

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
    printf -- 'welcome to the setup.sh \n';
    message='artsy times GO!'
    printer
    echo

# root check
# if [[ $EUID -ne 0 ]]; then
#        echo "This script must be run with sudo privelages from the user account" 
#           exit 1
# fi

# get the pass for the zip pkg
read -r -s -p  "Enter Setup Password from the IT Vault in 1Pass : " zip_pass 
printf -- '\n';

# /opt check & make directory / set permissions
if [[ -d /opt  ]]
then
       echo "/opt exists on your filesystem, proceeding"
else
       sudo mkdir -p /opt/
fi

sudo mkdir "$directory" 
sudo chown -R "$user" "$directory" 
cd "$directory" || return
 
printf -- 'downloading setup file \n';
echo
# curl -O $url/setup.zip
curl -o setup.zip -L "https://github.com/jasonarias/2021onboarding/blob/main/setup.zip?raw=true"
unzip -P $zip_pass setup.zip

# install any pkg packed in 
for f in *.pkg ;
    do sudo installer -verbose -pkg "$f" -target /
done ;

# change user icon --- ! not working atm....
    clear
    printf -- 'setting the user icon now \n';
    message='fingers crossed'
    printer
    echo

sudo dscl . delete /Users/"$user" jpegphoto
sudo dscl . delete /Users/"$user" Picture
sudo dscl . create /Users/"$user" Picture "$directory/user.tif"
# from https://apple.stackexchange.com/questions/117530/setting-account-picture-jpegphoto-with-dscl-in-terminal/367667#367667
set -e
declare -x USERNAME="$user"
declare -x USERPIC="$directory/user.tif"
declare -r DSIMPORT_CMD="/usr/bin/dsimport"
declare -r ID_CMD="/usr/bin/id"
declare -r MAPPINGS='0x0A 0x5C 0x3A 0x2C'
declare -r ATTRS='dsRecTypeStandard:Users 2 dsAttrTypeStandard:RecordName externalbinary:dsAttrTypeStandard:JPEGPhoto'
if [ ! -f "${USERPIC}" ]; then
      echo "User image required"
fi
# Check that the username exists - exit on error
${ID_CMD} "${USERNAME}" &>/dev/null || ( echo "User does not exist" && exit 1 )

declare -r PICIMPORT="$(mktemp /tmp/${USERNAME}_dsimport.XXXXXX)" || exit 1
printf "%s %s \n%s:%s" "${MAPPINGS}" "${ATTRS}" "${USERNAME}" "${USERPIC}" >"${PICIMPORT}"
${DSIMPORT_CMD} "${PICIMPORT}" /Local/Default M &&
        echo "Successfully imported ${USERPIC} for ${USERNAME}."
rm "${PICIMPORT}"

    clear
    printf -- 'ok, lets get brew installed \n';
    message='eyes open, it will ask questions'
    printer
    echo

# the brewables
# su -c '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"' $user
# sudo -u nathan mkdir shit <- simp working examp
sudo -u $user /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install google-chrome
brew install google-drive
brew install slack
brew install zoom
brew install 1password 
brew install notion
brew install desktoppr
brew install dockutil

    clear
    printf -- 'ok, brew installed? \n';
    printf -- 'setting dark mode and going in to clean up the dock'
    message='its gunna blink a lot'
    printer
    echo

# dark mode
dark mode -- needs reboot
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true

# dockutil cleanups
dockutil --remove 'Mail' ;
dockutil --remove 'Contacts' ;
dockutil --remove 'Calendar' ;
dockutil --remove 'Reminders' ;
dockutil --remove 'Maps' ;
dockutil --remove 'Messages' ;
dockutil --remove 'FaceTime' ;
dockutil --remove 'Pages' ;
dockutil --remove 'Numbers' ;
dockutil --remove 'Keynote' ;
dockutil --remove 'Safari' ;
dockutil --add /Applications/Google\ Chrome.app --position 3 ;
dockutil --add /Applications/Slack.app --position 4 ;
dockutil --add /Applications/zoom.us.app --position 5 ;
dockutil --add /Applications/1Password\ 7.app/ --position 6 ;

    clear
    printf -- 'ok we should be able to change the wallpaper'
    message='roll the dice'
    printer
    echo

# set wallpaper
desktoppr "$directory/wallpaper.png"

    clear
    printf -- 'computer renaming...'
    message='GO!   '
    printer
    echo

# rename computer
serial=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')
username=$(echo "${user}" | sed -e 's/\./-/g')
compname=${username}-${serial}
sudo scutil --set ComputerName "$compname"
sudo scutil --set HostName "$compname"
sudo scutil --set LocalHostName "$compname"

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

