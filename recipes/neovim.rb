#
# Cookbook Name:: workstation
# Recipe:: neovim
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'nodejs'
include_recipe 'workstation::python'
include_recipe 'workstation::dotfiles'
# include_recipe 'workstation::zsh'

bash 'install-neovim-python' do
  code <<-EOH
  PYTHON2_VERSION=$(pyenv install --list | grep "^  2[0-9\.]*$" | tail -1 | sed -E 's/ //g')
  PYTHON3_VERSION=$(pyenv install --list | grep "^  3[0-9\.]*$" | tail -1 | sed -E 's/ //g')
  pyenv install $PYTHON2_VERSION
  pyenv install $PYTHON3_VERSION
  pyenv virtualenv $PYTHON2_VERSION neovim2
  pyenv virtualenv $PYTHON3_VERSION neovim3
  PYENV_VERSION=neovim2 pip install neovim
  PYENV_VERSION=neovim3 pip install neovim
  EOH
  not_if 'pyenv versions | grep -q neovim2'
end

package 'neovim'

nodejs_npm 'neovim'

package 'universal-ctags/universal-ctags/universal-ctags' do
  options '--HEAD'
end

bash 'install ruby neovim plugin' do
  code <<-EOH
  sudo gem install neovim
  EOH
  not_if "gem list | grep -q neovim"
end

bash 'install vim-plug' do
  code <<-EOH
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  EOH
  not_if "[ -f ~/.local/share/nvim/site/autoload/plug.vim ]"
end
