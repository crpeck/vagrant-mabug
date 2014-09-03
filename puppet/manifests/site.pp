class { '::tomcat7':
  port            => '8080',
  java_opts       =>  [ '-XX:PermSize=256M', '-XX:MaxPermSize=356M' ],
  tomcat_managers =>  [
                        [ 'jenkins', '12345', 'manager-script' ],
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
  content => "curl -X POST http://localhost:8090/job/hello-world/build\n",
}

file { '/home/vagrant/.gitconfig':
  owner   => 'vagrant',
  group   => 'vagrant',
  mode    => '0644',
  ensure  => present,
  content => "[user]\n email = vagrantuser@some.where\n name = Vagrant User\n",
}
file { '/var/lib/tomcat7/webapps/ROOT/index.html':
  owner   => 'tomcat7',
  group   => 'tomcat7',
  mode    => '0644',
  ensure  => present,
  content => '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"> <head> <title>Jenkins Demo</title> </head> <body> <h1>It works !</h1> Click here to see the <a href="/hello-world">hello-world</a>i example'
}

