class deploynaut::kube(
  $helm_source,
  $aws_iam_authenticator_source
) {

  # Note we have to repackage the original release because the binary is contained in a directory.
  servicetools::install_tgz { "/usr/local/bin/helm":
    source => $helm_source,
  }
  ->file { '/var/www/.helm':
    ensure => 'directory',
    owner => www-data,
    group => www-data,
    mode => '0755',
  }
  ->exec { 'initialise helm':
    user => 'www-data',
    command => '/usr/local/bin/helm init --client-only --home /var/www/.helm',
    creates => '/var/www/.helm/repository',
  }

  servicetools::install_file { "/usr/local/bin/aws-iam-authenticator":
    source => $aws_iam_authenticator_source,
  }

}
