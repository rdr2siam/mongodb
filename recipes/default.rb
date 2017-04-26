#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Adding the MongoDB repository
template "/etc/yum.repos.d/mongodb-org.repo" do
  source 'mongodb.repo'
end

# Install
package "mongodb-org"

# Start and enable
service "mongod" do
  action [:start, :enable]
end

# Download example dataset
remote_file '/home/daver/downloads/primer-dataset.json' do
  source 'https://raw.githubusercontent.com/mongodb/docs-assets/primer-dataset/primer-dataset.json'
end

# Import data into the collection
execute 'mongo_import' do
  command 'mongoimport --db test --collection restaurants --drop --file downloads/primer-dataset.json'
  cwd '/home/daver'
end
