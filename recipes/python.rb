#
# Cookbook Name:: workstation
# Recipe:: python
#
# Copyright (c) 2016 Michaël Journo, All Rights Reserved.

# include_recipe 'dotfiles::dotfiles'


bash "install pyenv" do
  code <<-EOH
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  EOH
  not_if "[ -d ~/.pyenv ]"
end

bash "install pyenv virtualenv" do
  code <<-EOH
  git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
  EOH
  not_if "[ -d ~/.pyenv/plugins/pyenv-virtualenv ]"
end
