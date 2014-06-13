# puppet-bucky

A puppet module for managing and configuring bucky

https://github.com/cloudant/bucky

[![Build Status](https://travis-ci.org/electrical/puppet-bucky.png?branch=master)](https://travis-ci.org/electrical/puppet-bucky)

## Usage

Installation, make sure service is running and will be started at boot time:

     class { 'bucky': }

Removal/decommissioning:

     class { 'bucky':
       ensure => 'absent',
     }

Install everything but disable service(s) afterwards:

     class { 'bucky':
       status => 'disabled',
     }

For the meaning of all variables please check the bucky website.

### statsd

       statsd_enabled    => true
       statsd_ip         => '127.0.0.1'
       statsd_port       => 8125
       statsd_flush_time => 10

### collectd

       collectd_enabled          => true
       collectd_ip               => '127.0.0.1
       collectd_port             => 25826
       collectd_types            => []
       collectd_converters       => {}
       collectd_use_entry_points => 'True'

### metricsd

       metricsd_enabled    => true
       metricsd_ip         => '127.0.0.1'
       metricsd_port       => 23632
       metricsd_flush_time => 10
       metricsd_handlers   => ''

### graphite

       graphite_host               => '127.0.0.1'
       graphite_port               => 2003
       graphite_max_reconnect      => 3
       graphite_reconnect_delay    => 5
       graphite_pickle_enable      => 'False'
       graphite_pickle_buffer_size => 500

### General settings

       name_prefix           => 'None'
       name_postfix          => 'None'
       name_replace_char     => '_'
       name_strip_duplicates => 'True'
       name_host_trim        => []
    

## Dependencies
- https://forge.puppetlabs.com/puppetlabs/stdlib
- https://forge.puppetlabs.com/footballradar/python
