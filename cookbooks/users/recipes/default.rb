#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

search(:users, "*:*").each do |data|
  user data['id'] do
    comment data['comment']
    uid data['uid']
    gid data['gid']
    home data['home']
    shell data['shell']
  end

end

include_recipe "users::groups"