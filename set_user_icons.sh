#!/bin/bash
# vars
#This no longer works due to python2 deprecation
#user=$(python3 -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
#Instead:
user=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ {print $3}') 
directory=$HOME/.artsy
image="https://github.com/jasonarias/2021onboarding/blob/main/user.tif?raw=true"

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
    printf -- 'ok lets set the user icons \n';
    message='go go icons script'
    printer
    echo

while [[ ! -d "$directory" ]] 
    do
        echo 
        # echo -n "Enter Admin Password: "
        # read -r -s password
        #echo "$password" | sudo -S mkdir -p /opt/artsy
        mkdir "$directory"
   done
        echo 
        echo "$directory exists or was created!"
        echo 

cd "$directory" || exit
printf -- 'downloading images \n';
curl -o user.tif -L "$image"
printf -- 'changing the user icon \n';

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

