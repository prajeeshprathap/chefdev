#
# Cookbook Name:: windowsdev
# Recipe:: setupchoco
#
# Copyright (c) 2016 Prajeesh Prathap, All Rights Reserved.

# Configures chocolatey on the machine

include_recipe 'windows'

chocolatey_path = "#{ENV['SYSTEMDRIVE']}\\ProgramData\\chocolatey\\bin"

windows_path 'update_path_for_system' do
  action :add
  path chocolatey_path
end

ruby_block 'add_chocolatey_path' do
  block do
    new_path = "#{ENV['PATH']};#{chocolatey_path}"
    ENV['PATH'] = "#{ENV['PATH']};#{new_path}"
  end

  not_if {
    (ENV['PATH'].split(';').collect { | element | element.downcase }).include? chocolatey_path.downcase
  }
end

powershell_script 'chocolatey_install' do
  code <<-EOH
powershell -noprofile -inputformat none -noninteractive -executionpolicy bypass -command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
EOH
 #  not_if { ChocolateyHelpers::chocolatey_installed? }
  not_if "test-path '#{chocolatey_path}\\choco.exe'"
end

