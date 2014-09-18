# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
# uncomment to stay informed of updates to the box
  config.vm.box_check_update = false

  config.vm.box = "wmit/trusty64"

  config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 8090, host: 8090, auto_correct: true

  config.vm.provider :virtualbox do |vbox|
    vbox.customize ["modifyvm", :id, "--memory", 1024]
  end

  config.vm.synced_folder "", "/vagrant", create: true

  config.vm.provision "shell", path: "./init.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "site.pp"
    puppet.facter = {
      "vagrant" => "1"
    }
    puppet.options = [
      "--pluginsync --verbose"
    ]
  end

  config.vm.provision "shell", path: "./post-install.sh"

end
