class rbpod::monitoring::ssh inherits rbpod::monitoring {
  file { "/etc/monit/monitrc.d/openssh-server":
    content  => template('rbpod/ssh-monit.erb'),
    require => Class["monit::install"],
    mode    => 600,
    owner   => root,
    notify  => Class["monit::service"],
    } 
}
