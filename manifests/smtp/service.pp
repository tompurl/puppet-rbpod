class rbpod::smtp::service inherits rbpod::smtp {
  service { "nullmailer":
      ensure => running,
      hasstatus => true,
      require => Class["nullmailer"],
  }
}
