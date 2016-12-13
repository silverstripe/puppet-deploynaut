class deploynaut::params(
	$site_root = undef,
	$resources_root = undef,
	$service_enable = true,
	$service_ensure = "running",
	$service_manage = true,
	$service_name = "php-resque",
	$composer_user = "www-data",
	$composer_source = "https://getcomposer.org/download/1.2.4/composer.phar",
) {

}
