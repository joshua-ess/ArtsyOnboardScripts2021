#!/bin/bash
# notes: check and working Nh - 02.06.21 (and yes artsyloaner as non admin)
# vars
directory=/tmp/artsy
url="https://github.com/jasonarias/2021onboarding/blob/main/setup.zip?raw=true"
user=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

if [[ $EUID -ne 0 ]]; then
       echo "This script must be run with sudo privelages from the user account" 
          exit 1
fi

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

clear
echo -n "Enter Setup Password from the IT Vault in 1Pass : "
read -s password
echo

mkdir "$directory" 
sudo chown -R "$user" "$directory" 
cd "$directory" || return
 
    clear
    printf -- 'directory is ready \n';
    message='lets get the zip file'
    printer
    echo

curl -o setup.zip -L "$url"
unzip -P "$password" setup.zip

for f in *.pkg ;
    do sudo installer -verbose -pkg "$f" -target /
done ;

exit 0
