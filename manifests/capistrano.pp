class deploynaut::capistrano {

  exec { 'update_rubygems':
    path        => '/usr/local/bin:/usr/bin:/usr/sbin:/bin',
    refreshonly => true
  }

  package { 'ruby':
    ensure => '2.1.0'
  }
  -> package { 'rubygems-update':
    ensure   => '2.6.8',
    provider => 'gem',
    notify   => Exec['update_rubygems']
  }
  -> package { 'rack':
    ensure   => '1.6.6',
    provider => 'gem',
  }
  -> package { 'vegas':
    ensure   => '0.1.11',
    provider => 'gem',
  }
  -> package { 'sinatra':
    ensure   => '1.4.8',
    provider => 'gem',
  }
  -> package { 'net-ssh':
    ensure   => '4.2.0',
    provider => 'gem'
  }
  -> package { 'capistrano':
    ensure   => '2.15.7',
    provider => 'gem'
  }
  -> package { 'capistrano-multiconfig':
    ensure   => '0.0.4',
    provider => 'gem'
  }
  -> package { 'net-ssh-gateway':
    ensure => '2.0.0',
    provider => 'gem'
  }
  -> package { 'net-scp':
    ensure => '1.2.1',
    provider => 'gem'
  }
  -> package { 'net-sftp':
    ensure => '2.1.2',
    provider => 'gem'
  }
  -> package { 'highline':
    ensure => '1.7.10',
    provider => 'gem'
  }
}
