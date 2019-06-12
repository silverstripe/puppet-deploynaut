class deploynaut::install inherits deploynaut {

  package { 'redis-server':
    ensure => present
  }
  package { 'redis-tools':
    ensure => present
  }
  servicetools::install_file { '/usr/local/bin/composer':
    source => $composer_source,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  file {'/usr/bin/rsync_progress':
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => 'puppet:///modules/deploynaut/usr/bin/rsync_progress',
  }
}
