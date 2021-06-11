#!/bin/bash

file=https://raw.githubusercontent.com/jasonarias/2021onboarding/main/wallpaper.png
directory=$HOME/.artsy
desktoppr=/usr/local/bin/desktoppr
error_message="desktoppr not installed, please setup apps first"

mkdir "$directory"
cd "$directory" || exit

if [[ -f $desktoppr ]] 
    then
        echo "desktoppr is installed --- lets go"
        curl -O $file 
        desktoppr "$directory/wallpaper.png"
    else
        echo "$error_message"
fi

