#!/bin/bash
# idea = rm -rf /Users/loaner surrounded by if thens
# rm the user account as well, and then re-install from pkg
# 

bold=$(tput bold)  # ${bold}
std=$(tput sgr0) # ${std}
adminpkg=admin.pkg
user_dir=/Users/artsyloaner/
directory=/tmp/
icon_image="https://github.com/jasonarias/2021onboarding/blob/main/user.tif?raw=true"
url="https://github.com/jasonarias/2021onboarding/blob/main/setup.zip?raw=true"

cd $directory
echo "we should now be in:"
pwd

echo "lets get some passwords sorted"
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

echo "check for artsyloaner"
dscl . list Users|grep loaner 

if [ -d "$user_dir" ]
    then
        echo "$password" | sudo -S rm -rf "$user_dir" 
    else    
        echo "no artsylonaer to clean out, moving on"
fi

curl -o setup.zip -L "$url"
unzip -o -P "$setup_password" setup.zip

while [[ ! -f "$adminpkg" ]] # this checks for the adminpkg, if not there, prompt for pass
    do
        echo -n "Enter Setup Password from IT Vault: "
        read -s -r setup_password # added a -r from shellcheck, remove if issues
        unzip -o -P "$setup_password" setup.zip
   done

echo "$password" | sudo -S installer -verbose -pkg loaner.pkg -target /

system_user=artsyloaner
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


