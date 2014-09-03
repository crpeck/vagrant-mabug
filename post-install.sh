#!/bin/bash
#
# run this after puppet provision is finished
#sudo service tomcat7 restart
#sudo service jenkins start
# copy post-commit script to source tree for hello-world if needed
if [ -r /tmp/hello-world/.git/hooks/post-commit ]; then
  cp /vagrant/post-commit /tmp/hello-world/.git/hooks 
fi
#
# automagically create a 'hello-world' job in jenkins
cd /var/lib/jenkins/jobs
sudo tar xf /vagrant/hello-world-jenkins.tar
sudo chown jenkins:jenkins hello-world
sudo service jenkins restart
