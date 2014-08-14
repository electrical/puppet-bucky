# == Class: bucky::files
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
#   class { 'bucky::files': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class bucky::files {

  file { 'bucky_init':
    ensure  => 'present',
    path    => '/etc/init.d/bucky',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/init.d/${bucky::params::initscript}.erb"),
    require => Package["${bucky::params::package}"],
  }

}
