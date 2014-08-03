class rbpod ($smtp_host =  '',
             $alert_address = '',
             $smtp_user_name = '',
             $smtp_password = '',
             $smtp_port = '',
             $email_hostname = '',
             $monit_web_user_name = '',
             $monit_web_password = '',
             $ssh_port = '9000',
             $rbpod_domain = '',
             $timezone = '',
             $ssh_keypair_name = '',
             $ssh_keypair_key = '',
             $ssh_keypair_target_user = '',
             $rbpod_hostname = ''){

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    # Cool trick that automatically runs apt-get update once when the package
    # command is executed (one or more times).
    exec { "apt-update":
        command => "/usr/bin/apt-get update",
    }
    Exec["apt-update"] -> Package <| |>

    include rbpod::smtp
    include rbpod::monitoring
    include rbpod::tor
    include rbpod::location
    include rbpod::enhancers
    include rbpod::ssh
}

