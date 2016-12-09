# allows `$user` to sudo as `$sudo_composer_user`
# e.g. `www-data` can run `sudo -u $sudo_composer_user composer install`

class deploynaut::composer_sudo (
	$user = "www-data",
	$composer_user = "composer"
) {

	validate_string($user)
	validate_string($composer_user)

	file { "/etc/sudoers.d/10_${sudo_composer_user}":
		ensure => file,
		content => template('deploynaut/sudo_composer.erb'),
		owner => "root",
		group => "root",
		mode => "0440"
	}

}
