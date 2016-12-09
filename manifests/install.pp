class deploynaut::install inherits deploynaut {

	package { "redis-server":
		ensure => present
	}
	package { "redis-tools":
		ensure => present
	}

}
