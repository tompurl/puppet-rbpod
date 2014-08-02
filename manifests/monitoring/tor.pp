class rbpod::monitoring::tor inherits rbpod::monitoring {
  file { "/etc/monit/monitrc.d/tor":
    source  => "puppet:///modules/rbpod/rbpod-monit",
    require => Class["monit::install"],
    mode    => 600,
    owner   => root,
    notify  => Class["monit::service"],
    } 
}
