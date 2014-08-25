class rbpod::smtp::config inherits rbpod::smtp {

  # TODO Also set the default domain using the $rbpod_domain value.
  file { "/etc/nullmailer/defaultdomain":
    content  => template('rbpod/nullmailer-defaultdomain.erb'),
    require => Class["smtp::install"],
    mode    => 644,
    owner   => root,
    notify  => Class["smtp::service"],
  } 

}
