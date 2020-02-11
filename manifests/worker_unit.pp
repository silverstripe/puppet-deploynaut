define deploynaut::worker_unit(
  $service_name = 'php-resque',
) {
  $unit_name = "$service_name-$name"
  if $name != 1 {
    $prev_unit = $name - 1
    $prev_unit_name = "$service_name-$prev_unit"
  }
  file { "/etc/systemd/system/$unit_name.service":
    content => template("deploynaut/systemd_service.erb"),
  }
}
