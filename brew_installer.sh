#!/bin/bash
# vars
m1_dir=/opt/homebrew/bin
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
    printf -- 'ok, lets get brew installed \n';
    message='eyes open, it will ask questions'
    printer
    echo

# the brewables
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# need a check here
if [ -d "$m1_dir" ]
    then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME"/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        printf -- 'ok looks like we are not using M1 \n';
fi

brew install google-chrome
brew install google-drive
brew install slack
brew install zoom
brew install 1password 
brew install notion
brew install desktoppr
brew install dockutil
