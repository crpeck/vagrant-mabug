#!/bin/bash
date
if [ -f /vagrant/init.ran ]; then
  echo -e "\ninit.sh has already run, remove init.ran to run it again\n"
  exit 0
fi
echo "Provisioning....."
sudo apt-get update
echo -e "\nInstalling ruby-dev"
sudo apt-get install -y ruby-dev
echo -e "\nInstalling librarian-puppet"
sudo gem install librarian-puppet
cd /vagrant/puppet
echo -e "\nInstalling puppet modules from Puppetfile"
librarian-puppet install
echo -e "\nCreating file init.ran, to run init.sh during provisioning again you"
echo "must remove the file named init.ran"
date > /vagrant/init.ran
echo -e "\ninit.sh finished\n"
exit 0
