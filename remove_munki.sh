#!/bin/bash
sudo launchctl unload /Library/LaunchDaemons/com.googlecode.munki.*

sudo rm -rf "/Applications/Utilities/Managed Software Update.app"
sudo rm -rf "/Applications/Managed Software Center.app"

sudo rm -f /Library/LaunchDaemons/com.googlecode.munki.*
sudo rm -f /Library/LaunchAgents/com.googlecode.munki.*
sudo rm -rf "/Library/Managed Installs"
sudo rm -f /Library/Preferences/ManagedInstalls.plist
sudo rm -rf /usr/local/munki
sudo rm /etc/paths.d/munki

sudo pkgutil --forget com.googlecode.munki.admin
sudo pkgutil --forget com.googlecode.munki.app
sudo pkgutil --forget com.googlecode.munki.core
sudo pkgutil --forget com.googlecode.munki.launchd
sudo pkgutil --forget com.googlecode.munki.app_usage
sudo pkgutil --forget com.googlecode.munki.python

