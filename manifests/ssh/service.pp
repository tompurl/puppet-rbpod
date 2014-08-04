class rbpod::ssh::service inherits rbpod::ssh {
  service { "ssh":
      ensure => running,
      hasstatus => true,
      require => Package["openssh-server"],
  }
}
