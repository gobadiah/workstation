#
# Cookbook Name:: dotfiles
# Recipe:: oh-my-zsh
#
# Copyright (c) 2019 Michael Journo, All Rights Reserved.

# include_recipe 'dotfiles::zsh'

require 'etc'
user_id = Etc.getlogin

bash 'install-custom-fonts' do
  code <<-EOH
  cd /tmp
  rm -rf fonts
  git clone https://github.com/powerline/fonts.git
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
  EOH
  not_if "ls ~/Library/Fonts | grep -q \"Meslo LG S Regular for Powerline.ttf\""
end

bash 'install-oh-my-zsh' do
  code <<-EOH
  SHELL=zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  EOH
  not_if "test -d #{Dir.home}/.oh-my-zsh"
end

package 'direnv'
package 'autojump'
package 'diff-so-fancy'

git "/Users/#{user_id}/.oh-my-zsh/custom/plugins/zsh-completions" do
  repository 'https://github.com/zsh-users/zsh-completions'
  reference 'master'
  action :checkout
  not_if "test -d #{Dir.home}/.oh-my-zsh/custom/plugins/zsh-completions"
  only_if { ::File.exist?("#{Dir.home}/.oh-my-zsh") }
end

git "#{Dir.home}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" do
  repository 'https://github.com/zsh-users/zsh-autosuggestions'
  reference 'master'
  action :checkout
  not_if "test -d #{Dir.home}" \
    '/.oh-my-zsh/custom/plugins/zsh-autosuggestions'
  only_if { ::File.exist?("#{Dir.home}/.oh-my-zsh") }
end

git "#{Dir.home}/.oh-my-zsh/custom/themes/powerlevel9k" do
  repository 'https://github.com/bhilburn/powerlevel9k.git'
  reference 'master'
  action :checkout
  not_if "test -d #{Dir.home}" \
    '/.oh-my-zsh/custom/themes/powerlevel9k'
  only_if { ::File.exist?("#{Dir.home}/.oh-my-zsh") }
end 

git "#{Dir.home}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" do
  repository "https://github.com/zsh-users/zsh-syntax-highlighting"
  reference "master"
  action :checkout
  not_if "test -d #{Dir.home}" \
    '/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting'
end

git "#{Dir.home}/.oh-my-zsh/custom/plugins/history-search-multi-word" do
  repository "https://github.com/zdharma/history-search-multi-word"
  reference "master"
  action :checkout
  not_if "test -d #{Dir.home}" \
    '/.oh-my-zsh/custom/plugins/history-search-multi-word'
end
