class rbpod::updates::install inherits rbpod::updates {
    package { "cron-apt":
      ensure => "latest",
    }
}
