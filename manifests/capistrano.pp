class deploynaut::capistrano {

	exec { "update_rubygems":
		path => '/usr/local/bin:/usr/bin:/usr/sbin:/bin',
		refreshonly => true
	}

	package { "ruby":
		ensure => "present"
	} ->
	package { "rubygems-update":
		ensure => "2.6.8",
		provider => "gem",
		notify => Exec["update_rubygems"]
	} ->
	package { "net-ssh":
		ensure => "3.1.1",
		provider => "gem"
	} ->
	package { "capistrano":
		ensure => "2.15.7",
		provider => "gem"
	} ->
	package { "capistrano-multiconfig":
		ensure => "0.0.4",
		provider => "gem"
	} ->
	package { "resque":
		ensure => "1.26.0",
		provider => "gem"
	}

}
