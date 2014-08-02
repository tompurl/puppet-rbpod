class rbpod::tor inherits rbpod {
    # Install and configure an ssh server instance that is a hidden service
    # behind tor. Requires the tompurl/torssh package.
    class { 'torssh':
        ssh_port => $ssh_port,
    }
}
