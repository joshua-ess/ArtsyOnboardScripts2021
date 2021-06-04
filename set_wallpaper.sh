#!/bin/bash

file=https://raw.githubusercontent.com/jasonarias/2021onboarding/main/wallpaper.png
directory=/tmp
desktoppr=usr/local/bin/desktoppr
error_message="desktoppr not installed, please setup apps first"

cd $directory || exit

if [[ -f $desktoppr ]] 
    then
    curl -O $file 
        desktoppr "$directory/wallpaper.png"
    else
        echo "$error_message"

