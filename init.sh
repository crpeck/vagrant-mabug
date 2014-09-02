#!/bin/bash
date
if [ -f /vagrant/init.ran ]; then
  echo "init.sh has run, remove init.ran to run it again"
  exit 0
fi
echo "Provisioning....."
sudo apt-get update
date > /vagrant/init.ran
exit 0
