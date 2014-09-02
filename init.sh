#!/bin/bash
date
if [ -f /vagrant/init.ran ]; then
  echo "init.sh has run, remove init.ran to run it again"
  exit 0
fi
echo "Provisioning....."
sudo apt-get update
echo "Installing ruby-dev"
sudo apt-get install -y ruby-dev
echo "Installing librarian-puppet"
sudo gem install librarian-puppet
cd /vagrant/puppet
echo "Installing puppet modules from Puppetfile"
librarian-puppet install
date > /vagrant/init.ran
exit 0
