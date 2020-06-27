# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.define "DEBIAN-VM" do |debianvm|
    debianvm.vm.box = "debian/buster64"
    debianvm.vm.hostname = "DEBIAN-VM"
    debianvm.vm.box_url = "debian/buster64"
    # provision Nano text editor / wget /curl
    debianvm.vm.provision "shell", inline: <<-SHELL
      # to prevent stdin access    
      export DEBIAN_FRONTEND=noninteractive 
      # -qq No output except for errors
      apt-get -qq update 
      # ansible installed with apt instead of vagrant built-in because we don't need it at the moment
      # to update for next projects 
      apt-get -qq install -y nano wget curl ansible
    SHELL

    # DOCKER : install only -> 
    # vagrant ssh
    # docker build --rm -f "/vagrant/OC_Docker/Dockerfile" -t oc-buster-64 "/vagrant/OC_Docker"
    # docker run --rm -d -p 8080:80/tcp -p 8022:22/tcp oc-buster-64
    # debianvm.vm.provision "docker"

    # DOCKER : run container on VM bootup
    debianvm.vm.provision "docker" do |docker|
      # build image from Dockerfile
      docker.build_image "/vagrant/OC_Docker", 
        args: "-t oc-buster-64"
      # run container
      docker.run "oc-buster-64",
        args: "-p 8080:80/tcp -p 8022:22/tcp" 
    end
    debianvm.vm.network "forwarded_port", guest: 8080, host: 8080
    debianvm.vm.network "forwarded_port", guest: 8022, host: 8022
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.

  #   # provision Nano text editor
  #   config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y nano
  # SHELL
end
