# == Class: hatf2
#
# HatF2 allows the HatF2 web service to be installed, configured and run on startup.
#
# === Parameters
#
# Document parameters here.
#
# [*repo_key*]
#   Provide the secret repository key for gemfury.
#
# [*mongo_host*]
#   The IP of the host where mongoDB is installed.
#
# [*mongo_port*]
#   The port of the host where mongoDB is listening
#
# [*server_port*]
#   The port where hatf2-web should listen for incoming http search requests.
#
# [*encryption_key*]
#   The encryption key used for keeping cookies encrypted
#
# [*encryption_iv*]
#   The initialization vector required as part of the cookie cryptography
#
# [*github_clientsecret*]
#   Unknown
#
# [*github_clientid*]
#   unknown
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'hatf2':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <daniel@solong.co.uk>
#
# === Copyright
#
# Copyright 2016 So Long Ltd, unless otherwise noted.
#
class hatf2(
  $service_ensure     = $hatf2::params::service_ensure,
  $service_manage     = $hatf2::params::service_manage,
  $service_name       = $hatf2::params::service_name,
  $package_ensure     = $hatf2::params::package_ensure,
  $package_name       = $hatf2::params::package_name,
  $package_provider   = $hatf2::params::package_provider,
  $version            = $hatf2::params::version,
  $repo_key,
  #mongo db to connect to
  $mongo_collection   = $hatf2::params::mongo_collection,
  $mongo_db           = $hatf2::params::mongo_db,
  $mongo_host,
  $mongo_port,
  #port the web service should listen on
  $server_port,
  #encyrption key and initialization vector for cookies
  $encryption_key,
  $encryption_iv,
  #github key for oauth
  $github_clientsecret,
  $github_clientid,
  $domain             = $hatf2::params::domain,
  $repos_ensure               = $hatf2::params::repos_ensure,
  #should the service be managed
) inherits hatf2::params {


  case $::osfamily {

    'Debian': {
      if ! defined(Class['::ppa']) {
        class { '::ppa' :
         repo_key  => $repo_key,
         allow_unsigned => true
        }
      }
      $package_require = Class['apt::update']
    }
    default: {
      $package_require = undef
    }
  }

	  include hatf2::install
    include hatf2::config
    include hatf2::service

}
