class deploynaut (
	$site_root = $deploynaut::params::site_root,
	$resources_root = $deploynaut::params::resources_root,
	$service_enable = $deploynaut::params::service_enable,
	$service_ensure = $deploynaut::params::service_ensure,
	$service_manage = $deploynaut::params::service_manage,
	$service_name = $deploynaut::params::service_name
) inherits deploynaut::params {

	validate_string($site_root)
	validate_string($resources_root)

	include deploynaut::install
	include deploynaut::config
	include deploynaut::service

	Class["deploynaut::install"] ->
	Class["deploynaut::config"] ->
	Class["deploynaut::service"]

}
