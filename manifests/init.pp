# == Class: bucky2
#
# This class is able to install or remove bucky2 on a node.
# It manages the status of the related service.
#
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. If set to <tt>absent</tt>:
#   * The managed software packages are being uninstalled.
#   * Any traces of the packages will be purged as good as possible. This may
#     include existing configuration files. The exact behavior is provider
#     dependent. Q.v.:
#     * Puppet type reference: {package, "purgeable"}[http://j.mp/xbxmNP]
#     * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   * System modifications (if any) will be reverted as good as possible
#     (e.g. removal of created users, services, changed log settings, ...).
#   * This is thus destructive and should be used with care.
#   Defaults to <tt>present</tt>.
#
# [*autoupgrade*]
#   Boolean. If set to <tt>true</tt>, any managed package gets upgraded
#   on each Puppet run when the package provider is able to find a newer
#   version than the present one. The exact behavior is provider dependent.
#   Q.v.:
#   * Puppet type reference: {package, "upgradeable"}[http://j.mp/xbxmNP]
#   * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   Defaults to <tt>false</tt>.
#
# [*status*]
#   String to define the status of the service. Possible values:
#   * <tt>enabled</tt>: Service is running and will be started at boot time.
#   * <tt>disabled</tt>: Service is stopped and will not be started at boot
#     time.
#   * <tt>running</tt>: Service is running but will not be started at boot time.
#     You can use this to start a service on the first Puppet run instead of
#     the system startup.
#   * <tt>unmanaged</tt>: Service will not be started at boot time and Puppet
#     does not care whether the service is running or not. For example, this may
#     be useful if a cluster management software is used to decide when to start
#     the service plus assuring it is running on the desired node.
#   Defaults to <tt>enabled</tt>. The singular form ("service") is used for the
#   sake of convenience. Of course, the defined status affects all services if
#   more than one is managed (see <tt>service.pp</tt> to check if this is the
#   case).
#
# [*version*]
#   String to set the specific version you want to install.
#   Defaults to <tt>false</tt>.
#
# The default values for the parameters are set in bucky2::params. Have
# a look at the corresponding <tt>params.pp</tt> manifest file if you need more
# technical information about them.
#
#
# === Examples
#
# * Installation, make sure service is running and will be started at boot time:
#     class { 'bucky2': }
#
# * Removal/decommissioning:
#     class { 'bucky2':
#       ensure => 'absent',
#     }
#
# * Install everything but disable service(s) afterwards
#     class { 'bucky2':
#       status => 'disabled',
#     }
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class bucky2(
  $ensure                      = $bucky2::params::ensure,
  $autoupgrade                 = $bucky2::params::autoupgrade,
  $status                      = $bucky2::params::status,
  $version                     = false,
  $statsd_enabled              = $bucky2::params::statsd_enabled,
  $statsd_ip                   = $bucky2::params::statsd_ip,
  $statsd_port                 = $bucky2::params::statsd_port,
  $statsd_flush_time           = $bucky2::params::statsd_flush_time,
  $metricsd_enabled            = $bucky2::params::metricsd_enabled,
  $metricsd_ip                 = $bucky2::params::metricsd_ip,
  $metricsd_port               = $bucky2::params::metricsd_port,
  $metricsd_flush_time         = $bucky2::params::metricsd_flush_time,
  $metricsd_handlers           = $bucky2::params::metricsd_handlers,
  $collectd_enabled            = $bucky2::params::collectd_enabled,
  $collectd_ip                 = $bucky2::params::collectd_ip,
  $collectd_port               = $bucky2::params::collectd_port,
  $collectd_types              = $bucky2::params::collectd_types,
  $collectd_converters         = $bucky2::params::collectd_converters,
  $collectd_use_entry_points   = $bucky2::params::collectd_use_entry_points,
  $graphite_host               = $bucky2::params::graphite_host,
  $graphite_port               = $bucky2::params::graphite_port,
  $graphite_max_reconnect      = $bucky2::params::graphite_max_reconnect,
  $graphite_reconnect_delay    = $bucky2::params::graphite_reconnect_delay,
  $graphite_pickle_enable      = $bucky2::params::graphite_pickle_enable,
  $graphite_pickle_buffer_size = $bucky2::params::graphite_pickle_buffer_size,
  $name_prefix                 = $bucky2::params::name_prefix,
  $name_postfix                = $bucky2::params::name_postfix,
  $name_replace_char           = $bucky2::params::name_replace_char,
  $name_strip_duplicates       = $bucky2::params::name_strip_duplicates,
  $name_host_trim              = $bucky2::params::name_host_trim,
) inherits bucky2::params {

  #### Validate parameters

  # ensure
  if ! ($ensure in [ 'present', 'absent' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }

  # autoupgrade
  validate_bool($autoupgrade)
  validate_bool($statsd_enabled)
  validate_bool($metricsd_enabled)
  validate_bool($collectd_enabled)

  # service status
  if ! ($status in [ 'enabled', 'disabled', 'running', 'unmanaged' ]) {
    fail("\"${status}\" is not a valid status parameter value")
  }

  # IP addresses
  if ! is_ip_address($metricsd_ip) {
    fail("\"${metricsd_ip}\" is not a valid metricsd_ip parameter value")
  }

  if ! is_ip_address($statsd_ip) {
    fail("\"${statsd_ip}\" is not a valid statsd_ip parameter value")
  }

  if ! is_ip_address($collectd_ip) {
    fail("\"${collectd_ip}\" is not a valid collectd_ip parameter value")
  }

  #### Manage actions

  # package(s)
  class { 'bucky2::package': }

  # configuration
  class { 'bucky2::config': }

  # extra files
  class { 'bucky2::files': }

  # service(s)
  class { 'bucky2::service': }



  #### Manage relationships

  if $ensure == 'present' {
    # we need the software before configuring it
    Class['bucky2::package'] -> Class['bucky2::files']

    # we need the software and a working configuration before running a service
    Class['bucky2::package'] -> Class['bucky2::service']
    Class['bucky2::files']   -> Class['bucky2::service']

  } else {

    # make sure all services are getting stopped before software removal
    Class['bucky2::service'] -> Class['bucky2::package']
  }

}
