class hatf2::repo::apt(
  $location     = "https://${repo_key}@apt.fury.io/danielburrell/",
  $release      = ' ',
  $repos        = '/',
  $include_src  = false,
  #$key          = 'KEY HERE',
  #$key_source   = 'https://www.mit...signing-key.asc',
  $architecture = undef,
  $repo_key,
  $allow_unsigned = $hatf2::params::allow_unsigned
  ) {

  # ordering / ensure to get the last version of repository
  Class['hatf2::repo::apt']
  -> Class['apt::update']
  -> Package<| title == 'hatf2-web' |>

  $ensure_source = $hatf2::repos_ensure ? {
    false   => 'absent',
    default => 'present',
  }

	apt::source { 'fury':
    ensure       => $ensure_source,
    location     => $location,
    release      => $release,
    repos        => $repos,
    include_src  => $include_src,
    #key      => {
    #  'id'     => $key,
    #  'server' => $key_source,
    #}
    architecture => $architecture,
	  allow_unsigned => $allow_unsigned,
	}

}
