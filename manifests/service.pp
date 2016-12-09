class deploynaut::service inherits deploynaut {

	validate_string($service_name)
	validate_bool($service_enable)

	if !($service_ensure in ['running', 'stopped']) {
		fail('service_ensure parameter must be running or stopped')
	}

	if $service_manage {
		servicetools::install_systemd_unit { $service_name:
			service_options => {
			  "Type" => "forking",
			  "ExecStart" => "/usr/bin/php ${site_root}/framework/cli-script.php dev/resque/run queue=* count=4 flush=1",
			  "User" => "www-data",
			  "Restart" => "on-failure"
			},
			service_ensure => $service_ensure,
			service_enable => $service_enable
		}
	}

}
