class deploynaut::config inherits deploynaut {

	file {
		[
			"${resources_root}/deploynaut-resources",
			"${resources_root}/deploynaut-resources/envs",
			"${resources_root}/deploynaut-resources/git",
			"${resources_root}/deploynaut-resources/logs"
		]:
			ensure => "directory",
			owner => "www-data",
			group => "www-data",
			mode => "0755"
	}

	if $composer_user != "www-data" {

		user { $composer_user:
			ensure => "present",
			managehome => true
		}->
		exec { 'add www-data to composer group so that deploynaut can access git keys':
			command => '/usr/sbin/addgroup www-data composer',
			unless => "/usr/bin/groups www-data | /bin/grep composer",
		}->
		file { "${resources_root}/deploynaut-resources/gitkeys":
			ensure => "directory",
			owner => $composer_user,
			group => $composer_user,
			mode => "0775"
			}->
		file { "/etc/sudoers.d/10_${composer_user}":
			ensure => file,
			content => template('deploynaut/sudo_composer.erb'),
			owner => "root",
			group => "root",
			mode => "0440"
		}

	} else {

		file { "${resources_root}/deploynaut-resources/gitkeys":
			ensure => "directory",
			owner => $composer_user,
			group => $composer_user,
			mode => "0755"
		}

	}

}
