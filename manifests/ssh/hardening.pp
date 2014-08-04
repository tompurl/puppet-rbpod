class rbpod::ssh::hardening inherits rbpod::ssh {
    augeas { "configure_sshd":
        context => "/files/etc/ssh/sshd_config",
        changes => [  "set Port $ssh_port",
        "set PasswordAuthentication no",
        "set PermitRootLogin no",
        "set Protocol 2",
        ],
        require => Package["openssh-server"], 
        notify  => Service["ssh"]
    }
    # TODO install enhancers first
}
