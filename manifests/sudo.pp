class rbpod::sudo inherits rbpod {
  if $harden_sudo == 'true' {
    sudo::conf { "${host_login_name}":
      priority => 60,
      content  => "${host_login_name}        ALL=(ALL:ALL) ALL
      ${host_login_name}        ALL=NOPASSWD: /usr/bin/apt-get upgrade
      ${host_login_name}        ALL=NOPASSWD: /usr/bin/apt-get update",
    }
  }
}
