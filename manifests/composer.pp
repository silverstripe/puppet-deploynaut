class deploynaut::composer (
	$source = "https://getcomposer.org/download/1.2.4/composer.phar",
	$composer_dir = undef,
	$composer_user = undef,
	$composer_group = undef
) {
	servicetools::install_file { "/usr/local/bin/composer":
		source => $source,
		owner => "root",
		group => "root",
		mode => "0755"
	}

	# setup the .composer directory for a given user
	if $composer_dir != undef {
		validate_string($composer_user)
		validate_string($composer_group)

		user { $composer_user:
			ensure => "present"
		} ->
		file { $composer_dir:
			ensure => "directory",
			owner => $composer_user,
			group => $composer_group
			mode => "0755"
		}
	}

}
