#!/bin/bash

# chmod +x fresh_install.sh

# Things to install after a fresh installation of Ubuntu 23.10
# https://github.com/tigrouuu

# Check if script is being run by root
#if [[ $EUID -ne 0 ]]; then
#    printf "This script must be run as root!\n"
#    exit 1
#fi

ASTERIC="\n***************************************\n\n"
DIVIDER="\n_______________________________________\n\n"

# Welcome and instructions
printf $ASTERIC
printf "Things to install after a fresh installation of Ubuntu\n"
printf $ASTERIC

sudo apt-get -y update && sudo apt-get -y upgrade

sudo apt install build-essential ubuntu-restricted-extras apturl gdebi libfuse2 snapd fakeroot checkinstall curl git gufw wget
sudo apt install gnome-shell-extensions
sudo apt install rar unrar p7zip-full p7zip-rar unzip
sudo apt-get install filezilla google-chrome-stable gparted neofetch transmission vlc

sudo ubuntu-report -f send no
sudo apt install fonts-roboto fonts-cascadia-code fonts-firacode

sudo apt install code
code --verbose --vmodule="*/components/os_crypt/*=1"

sudo apt-get clean; sudo apt-get autoclean; sudo apt-get autoremove; sudo apt-get update; sudo apt-get upgrade

sudo apt install zsh
chsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
