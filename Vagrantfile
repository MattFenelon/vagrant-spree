# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.109.2"

  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--pae", "on"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "1"]
    # Force the box into 64 bit mode. For some reason the Ubuntu box
    # isn't configured correctly.
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
  end

  config.vm.provision :shell, :path => "provision_scripts/bootstrap.sh", :privileged => false
  config.vm.provision :shell, :path => "provision_scripts/install_git.sh", :privileged => false
  config.vm.provision :shell, :path => "provision_scripts/install_ruby.sh", :privileged => false
  config.vm.provision :shell, :path => "provision_scripts/install_rails.sh", :privileged => false
  config.vm.provision :shell, :path => "provision_scripts/install_spree.sh", :privileged => false
  config.vm.provision :shell, :path => "provision_scripts/install_postgres.sh", :privileged => true

  # Uncomment this line if you have edited the setup_spree_store.sh script to point to
  # the location of your Spree store's source and want a test database configured.
  # config.vm.provision :shell, :path => "provision_scripts/setup_spree_store.sh", :privileged => false

  # config.vm.network :forwarded_port, guest: 3000, host: 30000
end
