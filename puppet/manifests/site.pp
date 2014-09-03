class { '::tomcat7':
  port            => '8080',
  java_opts       =>  [ '-XX:PermSize=256M', '-XX:MaxPermSize=356M' ],
  tomcat_managers =>  [
                        [ 'jenkins', 'jenkins-password', 'manager-script' ],
                        [ 'manager', '12345', 'manager-gui' ],
                      ],
  manager_hosts   => '127.0.0.1|10\.0\.2\..*',
}


class { 'jenkins':
  configure_firewall => false,

  config_hash => {
    'HTTP_PORT' => { 'value' => '8090' },
    'AJP_PORT'  => { 'value' => '8099' },
  },

}

jenkins::plugin {
  'ansicolor' : ;
  'credentials' : ;
  'deploy' : ;
  'git' : ;
  'git-client' : ;
  'multiple-scms' : ;
  'parameterized-trigger' : ;
  'promoted-builds' : ;
  'scm-api' : ;
  'ssh' : ;
  'ssh-credentials' : ;
  'token-macro' : ;
  'ws-cleanup' : ;
}

package { 'maven':
  ensure  => present,
}

package { 'curl':
  ensure => present,
}
