#!/bin/bash
# vars
directory=/opt/artsy
url=https://github.com/jasonarias/2021onboarding/blob/main/

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
    printf -- 'welcome to the default users setup \n';
    message='checking for directory in /opt'
    printer
    echo

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
 
    clear
    printf -- 'directory is ready \n';
    message='lets get the zip file'
    printer
    echo

# get the pass for the zip pkg
clear
sleep 2s
echo
echo -n "Enter Setup Password from the IT Vault in 1Pass : "
read -s password
echo
# alternate pass input method
# read -r -s -p  "Enter Setup Password from the IT Vault in 1Pass : " zip_pass 
# printf -- '\n';

printf -- 'downloading setup file \n';
echo
curl -o setup.zip -L "https://github.com/jasonarias/2021onboarding/blob/main/setup.zip?raw=true"
unzip -P $zip_pass setup.zip

# install any pkg packed in 
for f in *.pkg ;
    do sudo installer -verbose -pkg "$f" -target /
done ;
# ok installed accounts


