#!/bin/bash
#This no longer works due to python2 deprecation
#user=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
#Instead:
user=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ {print $3}') 
# nonadmingroups="staff"  # for a non-admin user
# admingroups="admin _appserveradm _appserverusr" # for an admin user
sudo dscl . -append /Groups/admin GroupMembership "$user"
sudo dscl . -read /groups/admin GroupMembership
# echo -e "$userpass" |sudo -S  dseditgroup -o edit -t user -a "$user" staff 
# Add use to any specified groups
# for group in $admingroups ; do
#     dseditgroup -o edit -t user -a "$user" "$group"
# done
