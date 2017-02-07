#
# Cookbook Name:: mmc
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Cookbook Name:: mmc
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe "java"

#remote_file '/etc/mmc/mmc.zip' do
#  source 'https://build-000-nexus-000.levi-site.com/nexus/service/local/repositories/thirdparty/content/com/manh/sdn/mip-2016.zip'
#  owner 'root'
#  group 'root'
#  mode '0755'
#  action :create
#end

#batch 'unzip_mmc' do
#  code <<-EOH
#      cd /etc/mmc/
#      unzip –qo MMC-2016.zip
#    EOH
#end

execute 'unzip_mmc' do
  command 'unzip –qo /etc/mmc/MMC-2016.zip'
  cwd '/etc/mmc/'
  #not_if { File.exists?("/etc/mmc/") }
end


execute 'java_home_setup' do
  command '/etc/mmc/admin/setup.sh'
end

execute "keytool-generate" do
	command <<-eos
		keytool -genkey \
		-alias #{'mmc[:alias]'} \
		-dname "CN=#{'mmc[:CN]'}, OU=#{'mmc[:OU]'}, O=#{'mmc[:O]'}, L=#{'mmc[:L]'}, ST=#{'mmc[:ST]'}, C=#{'mmc[:C]'}" \
		-keypass #{'mmc[:keypass]'} \
		-storepass #{'mmc[:storepass]'} \
		-keystore #{'mmc[:path]'}
	eos
	#creates mmc[:path]
end

execute 'java_home_setup' do
  command '/etc/mmc/admin/startup.sh'
end
