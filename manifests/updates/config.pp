class rbpod::updates::config inherits rbpod::updates {
  file { "/etc/cron-apt/config":
    source  => "puppet:///modules/rbpod/cron-apt-config",
    require => Class["updates::install"],
    mode    => 644,
    owner   => root,
  } 
  # I don't need to set up a cron job that runs cron-apt because one is alredy
  # configured under /etc/cron.d/cron-apt when you install cron-apt.
}
