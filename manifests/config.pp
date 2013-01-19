# == Class: bucky::config
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
#   class { 'bucky::config': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class bucky::config {
 
  file { '/etc/bucky':
    ensure => directory,
    mode   => '0644',
    owner  => 'root',
    group  => 'root'
  }

  file { 'bucky_config':
    ensure  => present,
    path    => '/etc/bucky/bucky.conf',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/bucky/bucky.conf.erb"),
    notify  => Service['bucky'],
    require => File['/etc/bucky']
  }

}
