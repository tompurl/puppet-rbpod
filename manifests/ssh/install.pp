class rbpod::ssh::install inherits rbpod::ssh {
    package { 'openssh-server':
        ensure => "latest",
    }
}
