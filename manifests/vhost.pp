# Definition: openresty::vhost
#
# This class installs openresty Virtual Hosts
#
# Parameters:
# - The $port to configure the host on
# - The $docroot provides the Documentation Root variable
# - The $template option specifies whether to use the default template or override
# - The $priority of the site
# - The $serveraliases of the site
#
# Actions:
# - Install openresty Virtual Hosts
#
# Requires:
# - The openresty class
#
# Sample Usage:
#  openresty::vhost { 'site.name.fqdn':
#  priority => '20',
#  port => '80',
#  docroot => '/path/to/docroot',
#  }
#
define openresty::vhost (
  $docroot,
  $port          = '80',
  $template      = 'openresty/vhost/vhost.conf.erb',
  $priority      = '50',
  $serveraliases = '',
  $create_docroot = true,
  $enable        = true,
  $owner         = '',
  $groupowner    = '' ) {

  include openresty
  include openresty::params

  $real_owner = $owner ? {
    ''      => "${openresty::config_file_owner}",
    default => $owner,
  }

  $real_groupowner = $groupowner ? {
    ''      => "${openresty::config_file_group}",
    default => $groupowner,
  }

  $bool_create_docroot = any2bool($create_docroot)

  file { "${openresty::vdir}/${priority}-${name}.conf":
    content => template($template),
    mode    => $openresty::config_file_mode,
    owner   => $openresty::config_file_owner,
    group   => $openresty::config_file_group,
    require => Package['openresty'],
    notify  => Service['openresty'],
  }

  # Some OS specific settings:
  # On Debian/Ubuntu manages sites-enabled 
  case $::operatingsystem {
    ubuntu,debian,mint: {
      file { "ApacheVHostEnabled_$name":
        path    => "/etc/openresty/sites-enabled/${priority}-${name}.conf",
        ensure  => $enable ? {
          true  => "${openresty::vdir}/${priority}-${name}.conf",
          false => absent,
        },
        require => Package['openresty'],
      }
    }
    redhat,centos,scientific,fedora: {
      # include openresty::redhat
    }
    default: { }
  }

  if $bool_create_docroot == true {
    file { $docroot:
      ensure => directory,
      owner  => $real_owner,
      group  => $real_groupowner,
      mode   => '0775',
    }
  }

}
