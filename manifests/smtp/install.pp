class rbpod::smtp::install inherits rbpod::smtp {
    # Install nullmailer
    class { 'nullmailer':
        adminaddr   => $admin_addr,
        remoterelay => $smtp_host,
        remoteopts  => "--port=$smtp_port --starttls --user=$smtp_user_name --pass=$smtp_password",
    }

    # TODO Also set the default domain with tompurl.com?

    package { "mailutils":
        ensure => "latest",
    }
}
