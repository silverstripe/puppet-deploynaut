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

}
