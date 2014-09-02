class { '::tomcat7':
  port   => '8080',
  setenv => {
              db_url      => hiera('db_url'),
              db_user     => hiera('db_user'),
              db_password => hiera('db_password'),
            },
  java_opts       =>  [ '-XX:PermSize=256M', '-XX:MaxPermSize=356M' ],
  tomcat_managers =>  [
                        [ 'jenkins', 'jenkins-password', 'manager-script' ],
                        [ 'manager', '12345', 'manager-gui' ],
                      ],
  manager_hosts   => '127.0.0.1',
}

class { '::jenkins': }
jenkins::plugin {
  'git' : ;
}
