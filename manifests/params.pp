class hatf2::params {
  case $::osfamily {
    'Debian': {
      $package_ensure   = 'installed'
      $package_name     = 'hatf2-web'
      $service_name     = 'hatf2-web'
      $package_provider = 'apt'
      $version          = 'latest'
      $user    = 'hatf2'
      $group   = 'hatf2'
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }

  #install

  $manage_ssl_proxy = true
  $repos_ensure = true
  $repo_key = undef
  #mongo db to connect to
  $mongo_collection = 'hatf2'
  $mongo_db = 'hatf2'
  $mongo_host = undef
  $mongo_port = undef
  #port the web service should listen on
  $server_port = undef
  #encyrption key and initialization vector for cookies
  $encryption_key = undef
  $encryption_iv = undef
  #github key for oauth
  $github_clientsecret = undef
  $github_clientid = undef
  $domain = '.hatf2.com'
  $raw_domain = 'hatf2.com'
  #should the service be managed
  $service_manage = true
  $service_ensure = 'running'
  $allow_unsigned = true
}