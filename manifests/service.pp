class deploynaut::service inherits deploynaut {

  validate_string($service_name)
  validate_bool($service_enable)

  if !($service_ensure in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  if ($service_enable or $service_ensure=='running') {
    $first_surplus_worker = $service_workers + 1
  } else {
    # Disable all.
    $first_surplus_worker = 1
  }
  # Force to int
  $last_wanted_worker = 0 + $service_workers

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
    file { "/etc/systemd/system/$service_name@.service":
      # @ is required to be able to launch multiple aliased copies of the same service.
      content => template("deploynaut/systemd_service.erb"),
    } ->
    file { "/etc/systemd/system/$service_name.target":
      content => template("deploynaut/systemd_target.erb"),
    }

    $surplus_workers_pattern = "$service_name@{$first_surplus_worker..99}.service"
    exec { "Remove surplus workers ($first_surplus_worker..99)":
      # Disable and stop surplus workers. Systemd wouldn't know how to do that.
      command => "/bin/bash -c '/bin/systemctl disable $surplus_workers_pattern; /bin/systemctl stop $surplus_workers_pattern; /bin/systemctl reset-failed'",
      onlyif => "[ -f '/etc/systemd/system/$service_name.target.wants/php-resque@$first_surplus_worker.service' ]",
      provider => 'shell',
      require => File["/etc/systemd/system/$service_name@.service"],
      notify => Exec['deploynaut systemctl daemon reload'],
    } ->
    exec { "Add workers (1..$last_wanted_worker)":
      # Force target to re-enable, which will take care of adding workers.
      command => "/bin/systemctl disable $service_name.target",
      creates => "/etc/systemd/system/$service_name.target.wants/php-resque@$last_wanted_worker.service",
      provider => 'shell',
      require => File["/etc/systemd/system/$service_name@.service"],
      notify => Exec['deploynaut systemctl daemon reload'],
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
