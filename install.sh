#!/bin/bash

# Password-less sudo

echo "%staff ALL = (ALL) NOPASSWD: ALL" > /tmp/passwordless_sudo
sudo chown 0 /tmp/passwordless_sudo
sudo mv /tmp/passwordless_sudo /etc/sudoers.d/

# software updates

sudo softwareupdate -i -a

# Locate database

sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

# Homebrew

if ! command -v brew; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap caskroom/cask
  brew untap caskroom/cask
fi

# Chef

brew cask install chefdk

# Workstation

CUR=$PWD

cd /tmp/
rm -rf workstation
git clone https://github.com/gobadiah/workstation
cd workstation
berks install
rm -rf ../cookbooks
berks vendor ../cookbooks
cd ..
if [ -e $CUR/run_list.json ]
then
  chef-client -z -l info -j $CUR/run_list.json
else
  chef-client -z -l info -o 'recipe[workstation]'
fi

cd $CUR
