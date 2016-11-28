class hatf2::install(
	$version = 	$hatf2::params::version,
	$package_name = 		$hatf2::params::package_name,
	$user   = $hatf2::params::user,
	$group   = $hatf2::params::group
) inherits hatf2 {

	group { 'hatf2group':
		name   => $group,
		ensure => present,
	}

	user { 'hatf2user':
		name           => $user,
		groups         => [$group],
		password       => '*',
	}


	class { 'jdk_oracle': }

  package { 'hatf2-web':
	  name     => $package_name,
	  ensure   => $version,
	  require  => Apt::Source['fury'],
  }

}