class deploynaut::capistrano {

  exec { 'update_rubygems':
    path        => '/usr/local/bin:/usr/bin:/usr/sbin:/bin',
    refreshonly => true
  }

  package { 'ruby':
    ensure => 'present'
  }
  -> package { 'rubygems-update':
    ensure   => '2.6.8',
    provider => 'gem',
    notify   => Exec['update_rubygems']
  }
  -> package { 'redis':
    ensure   => '3.3.5',
    provider => 'gem'
  }
  -> package { 'redis-namespace':
    ensure   => '1.5.3',
    provider => 'gem'
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
    ensure   => '3.1.1',
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
  -> package { 'resque':
    ensure   => '1.26.0',
    provider => 'gem'
  }

}
