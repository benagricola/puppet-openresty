# Puppet module: openresty

This is a Puppet openresty module from the second generation of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

The openresty::resource:: classes and relevant code has been derived from https://github.com/zertico/puppetlabs-openresty.git
which is a fort of James Fryman /PuppetLabs original openresty module

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-openresty

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module.

For detailed info about the logic and usage patterns of Example42 modules read README.usage on Example42 main modules set.

## USAGE - Basic management

* Install openresty with default settings

        class { "openresty": }

* Install openresty with some useful settings

        class { "openresty":
          worker_connections => 4096; # the default value 1024 cannot match the needs of a large site
          keepalive_timeout => 120; # increase this according to your app's responde time
          client_max_body_size => '200m'; # increase this while your openresty works as an upload server.
        }

* Disable openresty service.

        class { "openresty":
          disable => true
        }

* Disable openresty service at boot time, but don't stop if is running.

        class { "openresty":
          disableboot => true
        }

* Remove openresty package

        class { "openresty":
          absent => true
        }

* Enable auditing without without making changes on existing openresty configuration files

        class { "openresty":
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { "openresty":
          source => [ "puppet:///modules/lab42/openresty/openresty.conf-${hostname}" , "puppet:///modules/lab42/openresty/openresty.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { "openresty":
          source_dir       => "puppet:///modules/lab42/openresty/conf/",
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file 

        class { "openresty":
          template => "example42/openresty/openresty.conf.erb",      
        }

* Define custom options that can be used in a custom template without the
  need to add parameters to the openresty class

        class { "openresty":
          template => "example42/openresty/openresty.conf.erb",    
          options  => {
            'LogLevel' => 'INFO',
            'UsePAM'   => 'yes',
          },
        }

* Automaticallly include a custom subclass

        class { "openresty:"
          my_class => 'openresty::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)
  Note that this option requires the usage of Example42 puppi module

        class { "openresty": 
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with
  a puppi::helper define ) to customize the output of puppi commands 

        class { "openresty":
          puppi        => true,
          puppi_helper => "myhelper", 
        }

* Activate automatic monitoring (recommended, but disabled by default)
  This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { "openresty":
          monitor      => true,
          monitor_tool => [ "nagios" , "monit" , "munin" ],
        }

* Activate automatic firewalling 
  This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { "openresty":       
          firewall      => true,
          firewall_tool => "iptables",
          firewall_src  => "10.42.0.0/24",
          firewall_dst  => "$ipaddress_eth0",
        }

## USAGE - VirtualHost

You have 2 different options to manage virtual hosts

* Use the openresty::vhost define, whose logic and parameters are similar to Example42 apache::vhost
  and where you have to set your docroot and eventually a custom template to use:

        openresty::vhost { 'mydomain.com' :
          template => 'myproject/openresty/mydomain/openresty.conf.erb',
          docroot  => '/var/www/mydomain',
        }

* Use the openresty::resource::vhost define which has been ported from puppetlabs/openresty module
  and it provides more flexibility in the management of virtual hosts and single location
  statements (with the openresty::resource::location define).

[![Build Status](https://travis-ci.org/example42/puppet-openresty.png?branch=master)](https://travis-ci.org/example42/puppet-openresty)
