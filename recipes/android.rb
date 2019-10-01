#
# Cookbook Name:: workstation
# Recipe:: android
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Hello

include_recipe 'workstation::java'

homebrew_cask 'android-sdk'
homebrew_cask 'android-ndk'

homebrew_cask 'android-studio'
homebrew_cask 'androidtool'
homebrew_cask 'android-file-transfer'
