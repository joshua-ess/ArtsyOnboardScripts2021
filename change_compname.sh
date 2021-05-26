#!/bin/sh
serial=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')

### Get the currently logged in user, in the Apple approved way

user=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
username=$(echo "${user}" | sed -e 's/\./-/g')

compname=${username}-${serial} # need some cut/awk command to keep characters less than say 50 just in case

#read -p "Please enter the desired computer name : " computerName
#sleep 1
scutil --set ComputerName "$compname"
scutil --set HostName "$compname"
scutil --set LocalHostName "$compname"
sleep 1
echo "Computer Name Set"
exit 0
