#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "apache2" do
  action :install
end

service "apache2" do
  action [ :enable, :start ]
end


execute "a2dissite default" do
  only_if do
    File.symlink? "/etc/apache2/sites-enabled/000-default"
  end
  only_if { !! File.symlink?("/etc/apache2/sites-enabled/000-default") }
  only_if { true }
  notifies :restart, "service[apache2]"
end

execute "echo #{node}"

node['apache']['sites'].each do |site_name,site_data|
  execute "echo #{site_name}"
end

node.apache.sites.each do |name,data|
  document_root = "/srv/apache/#{name}"

  template "/etc/apache2/sites-available/#{name}" do
    source "custom.erb"
    variables document_root: document_root, port: data.port
    mode 00644
    notifies :restart, "service[apache2]"
  end

  execute "a2ensite #{name}" do
    not_if { File.symlink? "/etc/apache2/sites-enabled/#{name}" }
    notifies :restart, "service[apache2]"
  end

  directory document_root do
    mode 00755
    recursive true
  end

  template "#{document_root}/index.html" do
    source "index.html.erb"
    mode 00644
    variables site_name: name, port: data.port
  end

end


# execute "rm /var/www/index.html" do
#   only_if { File.exists? "/var/www/index.html" }
# end

file "/var/www/index.html" do
  action :delete
end
