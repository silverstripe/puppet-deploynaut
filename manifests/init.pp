class deploynaut (
	$site_root = $deploynaut::params::site_root,
	$resources_root = $deploynaut::params::resources_root,
	$service_enable = $deploynaut::params::service_enable,
	$service_ensure = $deploynaut::params::service_ensure,
	$service_manage = $deploynaut::params::service_manage,
	$service_name = $deploynaut::params::service_name,
	$composer_user = $deploynaut::params::composer_user,
	$composer_source = $deploynaut::params::composer_source,
) inherits deploynaut::params {

	validate_string($site_root)
	validate_string($resources_root)
	if $composer_user != undef {
		validate_string($composer_user)
	}

	class { "deploynaut::install": }->
	class { "deploynaut::config": }->
	class { "deploynaut::service": }

}
