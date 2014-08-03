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
             $rbpod_hostname = ''){

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
    include rbpod::smtp
    include rbpod::monitoring
    include rbpod::tor
    include rbpod::location
}

