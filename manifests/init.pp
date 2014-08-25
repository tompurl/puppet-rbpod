class rbpod ($smtp_host =  '',
             $alert_address = '',
             $smtp_user_name = '',
             $smtp_password = '',
             $smtp_port = '',
             $monit_web_user_name = '',
             $monit_web_password = '',
             $ssh_port = '9000',
             $rbpod_domain = '',
             $timezone = '',
             $ssh_keypair_name = '',
             $ssh_keypair_key = '',
             #$ssh_keypair_target_user = '',
             $host_login_name = '',
             $btsync_web_ip = '0.0.0.0',
             $btsync_web_port = '8888',
             $btsync_web_login = 'admin',
             $btsync_web_password = '',
             # This breaks a Vagrant VM if it's true 
             $harden_sudo = 'true'){

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
    include rbpod::backup_software
    include rbpod::sudo
    include rbpod::updates
}

