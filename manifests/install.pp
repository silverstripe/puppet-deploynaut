class deploynaut::install inherits deploynaut {

  package { 'redis-server':
    ensure => '2:2.8.17-1+deb8u5'
  }
  package { 'redis-tools':
    ensure => '2:2.8.17-1+deb8u5'
  }
  servicetools::install_file { '/usr/local/bin/composer':
    source => $composer_source,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

}
