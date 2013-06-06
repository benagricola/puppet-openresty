# Class: openresty::params
#
# This class defines default parameters used by the main module class openresty
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to openresty class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class openresty::params {

  $gzip = 'on'
  $worker_connections = 1024
  $keepalive_timeout = 65
  $client_max_body_size = '10m'
  
  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'openresty',
  }

  $service = $::operatingsystem ? {
    default => 'openresty',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'openresty',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => 'www-data',
    default => 'openresty',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/openresty',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/openresty/openresty.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/openresty',
    default                   => '/etc/sysconfig/openresty',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/openresty.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/usr/share/openresty/html',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/openresty',
  }

  $log_file = $::operatingsystem ? {
    default => [ '/var/log/openresty/access.log' , '/var/log/openresty/error.log' ]
  }

  $port = '80'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
