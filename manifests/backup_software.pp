class rbpod::backup_software inherits rbpod {
  class { 'btsync':
    instances => {
      user => {
        storage_path => "/home/${host_login_name}/.sync",
        webui => {
          listen   => "${btsync_web_ip}:${btsync_web_port}",
          login    => $btsync_web_login,
          password => $btsync_web_password,
        }
      }
    }
  }
}

