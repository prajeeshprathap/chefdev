#
# Cookbook Name:: windowsdev
# Recipe:: setuppowershell
#
# Copyright (c) 2016 Prajeesh Prathap, All Rights Reserved.
powershell_script 'ExecutionPolicyUnrestricted' do
  code <<-EOH
powershell -noprofile -executionpolicy bypass -command {set-executionpolicy unrestricted -force -scope localmachine}
exit 0
EOH
  only_if "(get-executionpolicy -scope localmachine) -ne 'unrestricted'"
end

powershell_script 'ExecutionPolicyUnrestrictedX86' do
  architecture :i386  # Handle 32-bit Powershell (no-op if OS is 32-bit)
  code <<-EOH
powershell -noprofile -executionpolicy bypass -command {set-executionpolicy unrestricted -force -scope localmachine}
exit 0
EOH
  only_if "(get-executionpolicy -scope localmachine) -ne 'unrestricted'"
end

powershell_script 'Setup WINRM' do
  code <<-EOH
  Set-WSManQuickConfig -Force
  EOH
end

cookbook_file "#{ENV['USERPROFILE']}/configure_psmodules.ps1" do
  source 'configure_psmodules.ps1'
end

powershell_script "Run code from script to install modules" do
  code "#{ENV['USERPROFILE']}/configure_psmodules.ps1"
end