# == Class: bucky::package
#
# This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
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
#   class { 'bucky::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class bucky::package {

  #### Package management

  # set params: in operation
  if $bucky::ensure == 'present' {

    # Check if we want to install a specific version or not
    if $bucky::version == false {

      $package_ensure = $bucky::autoupgrade ? {
        true  => 'latest',
        false => 'present',
      }

    } else {

      # install specific version
      $package_ensure = $bucky::version

    }
  # set params: removal
  } else {
    $package_ensure = 'purged'
  }

  # action
  case $::operatingsystem {
    'CentOS', 'Fedora', 'Scientific', 'RedHat', 'Amazon': {
      package { 'bucky-needs-python-devel':
        ensure   => $package_ensure,
        name     => 'python-devel',
        provider => 'yum',
      }
    }
    'Debian', 'Ubuntu': {
      package { 'bucky-needs-python-devel':
        ensure   => $package_ensure,
        name     => 'python-dev',
        provider => 'apt'
      }
    }
    default: {
      fail("\"${module_name}\" provides no package default value
            for \"${::operatingsystem}\"")
    }
  }

  package { 'setproctitle':
    ensure   => $package_ensure,
    provider => 'pip',
    before   => Package["${bucky::params::package}"],
    require  => Package['bucky-needs-python-devel'],
  }

  package { $bucky::params::package :
    ensure   => $package_ensure,
    provider => 'pip',
  }

}
