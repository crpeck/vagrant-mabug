#!/bin/bash
# run scriptreplay on the vagrantbox - speed up replay time by 100
#
# verify the box is running
vagrant status|grep -q running
if [ $? -ne 0 ]; then
  echo "This Vagrant Box is not running, unfortunately"
  echo "replay cannot run without it being up"
  exit 1
fi
vagrant ssh -c "scriptreplay -t /vagrant/vagrant-up.tm /vagrant/vagrant-up.out 100"
exit
