#!/bin/sh
serial=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')
#This no longer works due to python2 deprecation
#user=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
#Instead:
user=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ {print $3}')
username=$(echo "${user}" | sed -e 's/\./-/g')
compname=${username}-${serial} # need some cut/awk command to keep characters less than say 50 just in case


sudo scutil --set ComputerName "$compname"
sudo scutil --set HostName "$compname"
sudo scutil --set LocalHostName "$compname"
echo "Computer Name Set"
exit 0
