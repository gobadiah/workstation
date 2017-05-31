#
# Cookbook Name:: workstation
# Recipe:: git
#
# Copyright (c) 2016 Michaël Journo, All Rights Reserved.

package 'git'

package 'git-flow-avh'

require 'etc'
user_id = Etc.getlogin

bash "install-vim-plug" do
  code <<-EOH
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  EOH
  user user_id
  not_if "test -d /Users/#{user_id}/.local/share/nvim/site/autoload/plug.vim"
end
