#
# Cookbook Name:: windowsdev
# Recipe:: default
#
# Copyright (c) 2016 Prajeesh Prathap, All Rights Reserved.
# Call all recipies from here

if node['platform'] == "windows"
  include_recipe 'windowsdev::setupchoco'
  include_recipe 'windowsdev::setuppowershell'
  include_recipe 'windowsdev::configurereg'
  include_recipe 'windowsdev::chocopackages'
end