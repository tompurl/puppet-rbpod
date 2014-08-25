class rbpod::monitoring inherits rbpod {

    include rbpod::monitoring::tor
    include rbpod::monitoring::btsync
    include rbpod::monitoring::ssh

    # Install monit using the tompurl/monit module.
    class { 'monit':
        alert_address  => $alert_address,
        smtp_host      => $smtp_host,
        smtp_port      => $smtp_port,
        smtp_user_name => $smtp_user_name,
        smtp_password  => $smtp_password,
        web_username   => $monit_web_user_name,
        web_password   => $monit_web_password,
    }
}
