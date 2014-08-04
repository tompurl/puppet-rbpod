class rbpod::ssh inherits rbpod {
  include rbpod::ssh::auth
  include rbpod::ssh::install
  include rbpod::ssh::service
  include rbpod::ssh::hardening
}
