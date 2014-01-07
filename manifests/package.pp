# == Class: bucky2::package
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
#   class { 'bucky2::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class bucky2::package {

  #### Package management

  include python

  # set params: in operation
  if $bucky2::ensure == 'present' {

    # Check if we want to install a specific version or not
    if $bucky2::version == false {

      $package_ensure = $bucky2::autoupgrade ? {
        true  => 'latest',
        false => 'present',
      }

    } else {

      # install specific version
      $package_ensure = $bucky2::version

    }

  # set params: removal
  } else {
    $package_ensure = 'purged'
  }

  # action
  package { $bucky2::params::package:
    ensure   => $package_ensure,
    provider => 'pip',
    source => 'git+https://github.com/trbs/bucky2.git#egg=bucky2',
    require  => Class['python'],
  }

}
