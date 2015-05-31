require 'rake'
require 'rspec/core/rake_task'
require 'yaml'
require 'ansible_spec'

VAGRANT_INVENTORY_PATH = '.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory'

def parse_inventory_line line
  matches = line.split
  hostname = matches.shift
  properties = Hash[
    matches.map { |match| match.split '=' }
  ]
  properties['name'] = hostname
  properties['user'] = 'vagrant'
  properties
end

def load_vagrant_inventory
  data = []
  File.open(VAGRANT_INVENTORY_PATH).each do |line|
    next if line.start_with? '#'
    next if line.chomp.empty?
    data << parse_inventory_line(line)
  end
  data
end


properties = AnsibleSpec.get_properties.map do |property|
  property['hosts'] = load_vagrant_inventory
  property
end

task :debug do
  p properties
end

namespace :serverspec do
  properties.each do |property|
    property['hosts'].each do |host|
      desc "Run serverspec for #{property['name']}"
      RSpec::Core::RakeTask.new(property['name'].to_sym) do |t|
        puts "Run serverspec for #{property['name']} to #{host}"

        ENV['TARGET_HOST'] = host['ansible_ssh_host']
        ENV['TARGET_PORT'] = host['ansible_ssh_port']
        ENV['TARGET_PRIVATE_KEY'] = ".vagrant/machines/#{host['name']}/virtualbox/private_key"
        ENV['TARGET_USER'] = host['user'] || property['user']
          
        t.pattern = 'roles/{' + property['roles'].join(',') + '}/spec/*_spec.rb'
      end
    end
  end

  desc 'Run all serverspecs'
  task :all => properties.map{ |p| p['name'].to_sym }
end

task :default => 'serverspec:all'

