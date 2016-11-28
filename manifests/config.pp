class hatf2::config (
  $user     = $hatf2::params::user,
  $group    = $hatf2::params::group,
)
inherits hatf2 {

  file { '/opt/solong/hatf2-web/current/conf/prod.properties':
    ensure  => file,
    owner   => $user,
    group   => $group,
    mode    => '400',
    content => template("${module_name}/prod.properties.erb"),
    require => Package['hatf2-web']
  }

}