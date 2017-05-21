class deploynaut::params(
  $site_root = undef,
  $resources_root = undef,
  $service_enable = true,
  $service_ensure = 'running',
  $service_manage = true,
  $service_name = 'php-resque',
  $service_workers = '4',
  $composer_user = 'www-data',
  $composer_source = 'https://getcomposer.org/download/1.4.2/composer.phar',
) {

}
