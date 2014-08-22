class rbpod::monitoring::btsync inherits rbpod::monitoring {
  file { "/etc/monit/monitrc.d/btsync":
    content  => template('rbpod/btsync-monit.erb'),
    require => Class["monit::install"],
    mode    => 600,
    owner   => root,
    notify  => Class["monit::service"],
    } 
}
