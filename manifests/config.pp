# == Class: bucky2::config
#
# This class exists to coordinate all configuration related actions,
# functionality and logical units in a central place.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'bucky2::config': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class bucky2::config {

  file { '/etc/bucky2':
    ensure => directory,
    mode   => '0644',
    owner  => 'root',
    group  => 'root'
  }

  file { 'bucky2_config':
    ensure  => present,
    path    => '/etc/bucky2/bucky2.conf',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/bucky2/bucky2.conf.erb"),
    notify  => Service['bucky2'],
    require => File['/etc/bucky2']
  }

}
