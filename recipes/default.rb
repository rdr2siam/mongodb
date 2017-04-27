#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
execute 'get-key' do
  command 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10'
end
# echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
execute 'create_list' do
  command 'echo deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list'
end

# sudo apt-get update
execute "apt-get-update" do
  command "apt-get update"
end

# Install
package "mongodb-org"
execute 'install monodb' do
  command 'apt-get install -y mongodb-org'
end

# Start and enable
service "mongod" do
  action [:start, :enable]
end

# Reboot
service 'mongod' do
  action [:stop, :restart]
end

# Download example dataset
remote_file 'primer-dataset.json' do
  source 'https://raw.githubusercontent.com/mongodb/docs-assets/primer-dataset/primer-dataset.json'
end

# Import data into the collection
execute 'mongo_import' do
  command 'mongoimport --db test --collection restaurants --drop --file primer-dataset.json'
end
