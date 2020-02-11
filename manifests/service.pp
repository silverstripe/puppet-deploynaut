class deploynaut::service inherits deploynaut {

  validate_string($service_name)
  validate_bool($service_enable)

  if !($service_ensure in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  $workers = range("1", $service_workers)

  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Exec['deploynaut systemctl daemon reload'],
  }

  # Manage N workers through systemd, so that we can get systemd to gracefully restart them.
  if $service_manage {
    file { "/etc/systemd/system/$service_name-flush.service":
      content => template("deploynaut/systemd_flush_service.erb"),
    } ->
    deploynaut::worker_unit{$workers:
      service_name => $service_name,
      notify => Exec['deploynaut systemctl daemon reload'],
    } ->
    file { "/etc/systemd/system/$service_name.target":
      content => template("deploynaut/systemd_target.erb"),
    }

    exec { 'deploynaut systemctl daemon reload':
      command => '/bin/systemctl daemon-reload',
      refreshonly => true,
    } ~>
    service { "$service_name.target":
      provider => 'systemd',
      ensure => $service_ensure,
      enable => $service_enable,
    }

  }

}
