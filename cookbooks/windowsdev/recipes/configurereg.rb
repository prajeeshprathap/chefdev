#
# Cookbook Name:: windowsdev
# Recipe:: configurereg
#
# Copyright (c) 2016 Prajeesh Prathap, All Rights Reserved.


registry_key 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' do
  values [{
    :name => 'EnableLUA',
    :type => :dword,
    :data => 1
  }]
  action :create
end