#!/bin/bash

set -ex

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

brew cask install chef/chef/chefdk

# lastpass

# fixing permissions
sudo chown -R $USER:admin /usr/local/lib
brew install lastpass-cli

# Workstation

[ -d $HOME/.dotfiles ] || git clone https://github.com/gobadiah/workstation $HOME/.dotfiles

pushd $HOME/.dotfiles

berks install
rm -rf cookbooks
berks vendor cookbooks
chef-client -z -l info -o 'recipe[dotfiles]'

popd
