class rbpod::enhancers inherits rbpod {
    # Installs the "enhancers" packages that you need to do almost anything.
    $enhancers = [ "vim",
                   "tmux",
                   "mlocate",
                   "libaugeas-ruby1.9.1",
                   "tcpdump",
                   "elinks",
                   "nethogs",
                   "htop"]
    package { $enhancers: 
        ensure => "latest",
        before => Class["rbpod::ssh::hardening"],
    }
}
