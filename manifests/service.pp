class hatf2::service(
  $service_ensure = $hatf2::service_ensure,
  $service_manage = $hatf2::service_manage,
  $service_name   = $hatf2::service_name,
  $manage_ssl_proxy = $hatf2::manage_ssl_proxy,
  $server_port = $hatf2::server_port,
  $raw_domain = $hatf2::raw_domain,
) inherits hatf2 {
  
  validate_re($service_ensure, '^(running|stopped)$')
  validate_bool($service_manage)

  require jdk_oracle
    
  if ($service_manage) {
    if $service_ensure == 'running' {
      $ensure_real = 'running'
      $enable_real = true
    } else {
      $ensure_real = 'stopped'
      $enable_real = false
    }

    service { 'hatf2-web':
      ensure     => $ensure_real,
      enable     => $enable_real,
      hasstatus  => true,
      hasrestart => true,
      name       => $service_name,
	    require    => Package['hatf2-web']
    }
  }

}