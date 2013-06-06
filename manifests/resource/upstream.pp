# define: openresty::resource::upstream
#
# This definition creates a new upstream proxy entry for openresty
#
# Parameters:
#   [*ensure*]      - Enables or disables the specified location (present|absent)
#   [*members*]     - Array of member URIs for openresty to connect to. Must follow valid openresty syntax.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  openresty::resource::upstream { 'proxypass':
#    ensure  => present,
#    members => [
#      'localhost:3000',
#      'localhost:3001',
#      'localhost:3002',
#    ],
#  }
define openresty::resource::upstream (
  $ensure = 'present',
  $members
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { "${openresty::config_dir}/conf.d/${name}-upstream.conf":
    ensure   => $ensure ? {
      'absent' => absent,
      default  => 'file',
    },
    content  => template('openresty/conf.d/upstream.erb'),
    notify   => $openresty::manage_service_autorestart,
  }
}
