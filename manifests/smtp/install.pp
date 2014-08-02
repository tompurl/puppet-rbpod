class rbpod::smtp::install inherits rbpod::smtp {
    # Install monit
    class { 'monit':
        alert_address  => $alert_address,
        smtp_host      => $smtp_host,
        smtp_port      => $smtp_port,
        smtp_user_name => $smtp_user_name,
        smtp_password  => $smtp_password,
        email_hostname => $email_hostname,
        web_username   => $monit_web_user_name,
        web_password   => $monit_web_password,
    }

    # Install nullmailer
    class { 'nullmailer':
        adminaddr   => $admin_addr,
        remoterelay => $smtp_host,
        remoteopts  => "--port=$smtp_port --starttls --user=$smtp_user_name --pass=$smtp_password",
    }

    package { "mailutils":
        ensure => "latest",
    }
}
