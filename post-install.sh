#!/bin/bash
#
# run this after puppet provision is finished
#
# automagically create a 'hello-world' job in jenkins
cd /var/lib/jenkins/jobs
sudo tar xf /vagrant/hello-world.tar
sudo chown jenkins:jenkins hello-world
sudo service jenkins restart
sudo service tomcat7 restart
