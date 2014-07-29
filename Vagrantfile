# -*- mode: ruby -*-
# vi: set ft=ruby :

$shell = <<SCRIPT


# Install Mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get -y install mongodb-org 
sudo service mongod start


# Install nginx
deb http://nginx.org/packages/ubuntu/ lucid nginx
deb-src http://nginx.org/packages/ubuntu/ lucid nginx

sudo -s
nginx=stable # use nginx=development for latest development version
echo "deb http://ppa.launchpad.net/nginx/$nginx/ubuntu lucid main" > /etc/apt/sources.list.d/nginx-$nginx-lucid.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
apt-get update 
apt-get -y install nginx


# Install rails


gem install rails --version 4.1.4
rbenv rehash


echo 'cd /vagrant' >> /home/vagrant/.bashrc


# install gem without rdoc
echo 'gem: --no-document' >> /home/vagrant/.gemrc



SCRIPT


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.network :forwarded_port, host: 3000, guest: 3000  # yeoman fronted
  config.vm.network :forwarded_port, host: 5000, guest: 5000  # Rails api
  

  # bootstrap shell 
  config.vm.provision :shell, :path => "puppet/ubuntu.sh"
  config.vm.provision :shell, :inline => $shell

  # puppet 
  config.vm.synced_folder "puppet", "/puppet"
  #config.vm.synced_folder "www", "/www"
  #  create: true,
  #  owner: "vagrant",
  #  group: "vagrant"
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path    = "puppet/modules"
    puppet.manifest_file  = "default.pp"
  end

end
