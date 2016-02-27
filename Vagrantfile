# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.network 'forwarded_port', guest: 3000, host: 3000
  config.vm.network 'forwarded_port', guest: 80, host: 3001
  config.vm.network 'private_network', ip: '192.168.33.10'

  config.vm.synced_folder '.', '/vagrant'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
  end

  config.vm.provision :shell, privileged: false, path: 'bootstrap.sh'
end
