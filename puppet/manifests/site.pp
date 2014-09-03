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

  config_hash   => {
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

vcsrepo { '/usr/local/src/hello-world':
  owner    => 'vagrant',
  group    => 'vagrant',
  ensure   => 'present',
  provider => git,
  source   => 'https://github.com/crpeck/hello-world.git',
  require  => Class['::jenkins'],
  before   => File['/usr/local/src/hello-world/.git/hooks/post-commit'],
}

file { '/usr/local/src/hello-world/.git/hooks/post-commit':
  owner   => 'vagrant',
  group   => 'vagrant',
  mode    => '0755',
  ensure  => present,
  content => "curl -X POST http://localhost:8080/job/hello-world/build",
}

