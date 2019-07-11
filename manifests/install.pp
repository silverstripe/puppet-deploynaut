class deploynaut::install inherits deploynaut {

  package { 'redis-server':
    ensure => present
  }
  package { 'redis-tools':
    ensure => present
  }

  $composer_path = "/usr/local/bin/composer-${composer_version}"
  servicetools::install_file { $composer_path:
    source => "https://getcomposer.org/download/${composer_version}/composer.phar",
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  } ->
  file { '/usr/local/bin/composer':
    ensure => link,
    target => $composer_path,
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
