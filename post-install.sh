#!/bin/bash
#
# run this after puppet provision is finished
#
# this copies anything under the jenkins-files diretory
# here over to /var/lib/jenkins on the vagrant box
#
# updates jeknins main config file and configures maven
# automagically creates a 'hello-world' job in jenkins
#
echo -e "\nStarting Post Install provisioning"
echo -e "\nConfiguring Jenkins"
cd /vagrant/jenkins-files
tar cf - . | (cd /var/lib/jenkins; sudo tar xf -)
sudo chown -R jenkins:jenkins /var/lib/jenkins
echo -e "\nRestarting Jenkins"
sudo service jenkins restart
echo "Restarting Tomcat"
sudo service tomcat7 restart
echo -e "\nJenkins is available at http://localhost:8090"
echo "Tomcat manager at http://localhost:8080/manager"
echo "  user=manager, password=12345"
