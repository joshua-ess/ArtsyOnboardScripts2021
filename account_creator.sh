#!/bin/bash
# vars
bold=$(tput bold)  # ${bold}
# red=$(tput setaf 1) # ${red}
std=$(tput sgr0) # ${std}
adminpkg=admin.pkg
directory=$HOME/.artsy
icon_image="https://github.com/jasonarias/2021onboarding/blob/main/user.tif?raw=true"
url="https://github.com/jasonarias/2021onboarding/blob/main/setup.zip?raw=true"
# user=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# sudo check
# if [[ $EUID -ne 0 ]]; then
#         echo "This script must be run with sudo privelages from the user account" 
#            exit 1
# fi
# 
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
    message='account creator is alive lets go'
    printer
    echo


if [ -z "$password" ] 
    then
        echo 
        echo -n "Enter Admin Password for $bold SUDO $std: "
        read -r -s password
    else
        echo "seems we have a password already"
fi

if [ -z "$setup_password" ] 
    then
        echo -n "Enter Setup Password from IT Vault: "
        read -s -r setup_password # added a -r from shellcheck, remove if issues
        echo
    else
        echo "setup_password seems set"
fi

if [ -d "$directory" ]
    then
        cd "$directory" || return
    else    
        mkdir "$directory" && cd "$directory"
fi

    echo "we should be in the $(pwd)"
    message='...lets get the zip file'
    printer
    echo

curl -o setup.zip -L "$url"
unzip -o -P "$setup_password" setup.zip

while [[ ! -f "$adminpkg" ]] # this checks for the adminpkg, if not there, prompt for pass
    do
        echo -n "Enter Setup Password from IT Vault: "
        read -s -r setup_password # added a -r from shellcheck, remove if issues
        unzip -o -P "$setup_password" setup.zip
   done

for f in *.pkg ;
    do echo "$password"| sudo -S installer -verbose -pkg "$f" -target /
done 

for f in *.pkg ;
    do rm "$f"
done

# begin icon setter block



system_user=artsytech
curl -o user.tif -L "$icon_image"
printf -- 'changing the user icon \n';
echo "$password"| sudo -S dscl . delete /Users/"$system_user" jpegphoto
echo "$password"| sudo -S dscl . delete /Users/"$system_user" Picture
echo "$password"| sudo -S dscl . create /Users/"$system_user" Picture "$directory/user.tif"
set -e
declare -x USERNAME="$system_user"
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

# second account
system_user=artsyloaner
printf -- 'changing the user icon \n';
echo "$password"| sudo -S dscl . delete /Users/"$system_user" jpegphoto
echo "$password"| sudo -S dscl . delete /Users/"$system_user" Picture
echo "$password"| sudo -S dscl . create /Users/"$system_user" Picture "$directory/user.tif"
set -e
declare -x USERNAME="$system_user"
# declare -r MAPPINGS='0x0A 0x5C 0x3A 0x2C'
# declare -r ATTRS='dsRecTypeStandard:Users 2 dsAttrTypeStandard:RecordName externalbinary:dsAttrTypeStandard:JPEGPhoto'
if [ ! -f "${USERPIC}" ]; then
      echo "User image required"
fi
# Check that the username exists - exit on error
${ID_CMD} "${USERNAME}" &>/dev/null || ( echo "User does not exist" && exit 1 )
# declare -r PICIMPORT="$(mktemp /tmp/${USERNAME}_dsimport.XXXXXX)" || exit 1
printf "%s %s \n%s:%s" "${MAPPINGS}" "${ATTRS}" "${USERNAME}" "${USERPIC}" >"${PICIMPORT}"
${DSIMPORT_CMD} "${PICIMPORT}" /Local/Default M &&
        echo "Successfully imported ${USERPIC} for ${USERNAME}."
rm "${PICIMPORT}"

