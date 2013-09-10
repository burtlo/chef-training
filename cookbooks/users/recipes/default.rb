#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

decrypted = Chef::EncryptedDataBagItem.load "passwords", "userlist"

search(:users, "*:*").each do |data|
  user data['id'] do
    comment data['comment']
    uid data['uid']
    gid data['gid']
    home data['home']
    shell data['shell']
    password decrypted[ data['id'] ]
  end

end


# include_recipe "motd::default"

include_recipe "users::groups"