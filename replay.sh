#!/bin/bash
# run scriptreplay on the vagrantbox - speed up replay time by 100
vagrant ssh -c "scriptreplay -t /vagrant/vagrant-up.tm /vagrant/vagrant-up.out 100"
exit
