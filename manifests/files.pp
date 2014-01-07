# == Class: bucky2::files
#
# This class ensures any extra files to be written
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
#   class { 'bucky2::files': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class bucky2::files {

  file { 'bucky2_init':
    ensure  => 'present',
    path    => '/etc/init.d/bucky2',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    source  => "puppet:///modules/${module_name}/etc/init.d/${bucky2::params::initscript}",
  }

}
