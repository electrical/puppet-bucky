# == Class: bucky::params
#
# This class exists to
# 1. Declutter the default value assignment for class parameters.
# 2. Manage internally used module variables in a central place.
#
# Therefore, many operating system dependent differences (names, paths, ...)
# are addressed in here.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class is not intended to be used directly.
#
#
# === Links
#
# * {Puppet Docs: Using Parameterized Classes}[http://j.mp/nVpyWY]
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class bucky::params {

  #### Default values for the parameters of the main module class, init.pp

  # ensure
  $ensure = 'present'

  # autoupgrade
  $autoupgrade = false

  # service status
  $status = 'enabled'


  #### Config file defaults

  # metricsd
  $metricsd_enabled   = false
  $metricsd_ip        = '127.0.0.1'
  $metricsd_port      = '23632'
  $metricsd_flushtime = '10.0'

  # collectd
  $collectd_enabled          = false
  $collectd_ip               = '127.0.0.1'
  $collectd_port             = '25826'
  $collectd_types            = '[]'
  $collectd_converters       = '{}'
  $collectd_use_entry_points = 'True'

  # statsd
  $statsd_enabled   = false
  $statsd_ip        = '127.0.0.1'
  $statsd_port      = '8125'
  $statsd_flush_time = '10.0'

  # graphite
  $graphite_host               = '127.0.0.1'
  $graphite_port               = '2003'
  $graphite_max_reconnect      = '3'
  $graphite_reconnect_delay    = '5'
  $graphite_pickle_enable      = 'False'
  $graphite_pickle_buffer_size = '500'

  # general settings
  $name_prefix           = 'None'
  $name_postfix          = 'None'
  $name_replace_char     = '_'
  $name_strip_duplicates = 'True'
  $name_host_trim        = '[]'

  #### Internal module values

  # packages
  case $::operatingsystem {
    'CentOS', 'Fedora', 'Scientific', 'RedHat', 'Amazon': {
      # main application
      $package = [ 'bucky' ]
    }
    'Debian', 'Ubuntu': {
      # main application
      $package = [ 'bucky' ]
    }
    default: {
      fail("\"${module_name}\" provides no package default value
            for \"${::operatingsystem}\"")
    }
  }

  # service parameters
  case $::operatingsystem {
    'CentOS', 'Fedora', 'Scientific', 'RedHat', 'Amazon': {
      $initscript         = 'bucky.RedHat'
      $service_name       = 'bucky'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
    }
    'Debian', 'Ubuntu': {
      $initscript         = 'bucky.Debian'
      $service_name       = 'bucky'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
    }
    default: {
      fail("\"${module_name}\" provides no service parameters
            for \"${::operatingsystem}\"")
    }
  }

}
