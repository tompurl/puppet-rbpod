class rbpod::location inherits rbpod {
  # This class handles all location-related settings.

    class { 'timezone':
        timezone => $timezone,
  }
}
