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
    $pip_action = 'install'
    $pip_source = 'git+https://github.com/trbs/bucky.git#egg=bucky'
    $pip_test_cmd = '/usr/bin/pip show bucky | grep Version'
  # set params: removal
  } else {
    $package_ensure = 'purged'
    $pip_action = 'uninstall -y'
    $pip_source = 'bucky'
    $pip_test_cmd = '/bin/false'
  }

  # action
  #package { $bucky::params::package:
  #  ensure   => $package_ensure,
  #  provider => 'pip',
  #  source => 'git+https://github.com/trbs/bucky.git',
  #}

  exec { "pip_${bucky::params::package}":
    command => "/usr/bin/pip ${pip_action} -q ${pip_source}",
    unless => "${pip_test_cmd}",
    returns => [0, 1]
  }

}
