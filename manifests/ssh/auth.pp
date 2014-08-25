class rbpod::ssh::auth inherits rbpod::ssh {
  # Set up keypair auth
  ssh_authorized_key { 'pi_key':
      name    => $ssh_keypair_name,
      ensure  => present,
      key     => $ssh_keypair_key,
      type    => "ssh-rsa",
      #user    => $ssh_keypair_target_user,
      user    => $host_login_name,
  }
}
