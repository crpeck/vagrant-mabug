#!/bin/bash
#
# vagrant pre-puppet provisoning script.
# Runs before puppet (See the Vagrantfile) and:
#  runs apt-get update (or stuff can't get installed)
#  installs ruby-dev (pre-req for librarian-puppet)
#  installs librarian-puppet via gem
#  runs librarian-puppet to install puppet modules
#  creates an init.ran file, so another provision won't bother running this script
#
echo ""
#
if [ -f /vagrant/init.ran ]; then
  echo "init.sh shell provisioner already ran, skipping it this time"
  echo "if you want it to run, remove the file init.ran and rerun"
  echo "vagrant provision"
  exit 0
fi
#
echo "Provisioning..."
sudo apt-get update
#
echo -e "\nInstalling ruby-dev"
sudo apt-get install -y ruby-dev
#
echo -e "\nInstalling librarian-puppet"
sudo gem install librarian-puppet
#
cd /vagrant/puppet
echo -e "\nInstalling puppet modules from Puppetfile"
librarian-puppet install
#
echo -e "\nCreating file init.ran, to run init.sh during provisioning again you"
echo "must remove the file named init.ran"
date > /vagrant/init.ran
#
echo -e "\ninit.sh finished\n"
exit 0
