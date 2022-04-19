#
# @summary Manage mcelog
#
# @param package_name
#   The name of the package.
# @param config_file_path
#   The path of mcelog configuration file.
# @param config_file_template
#   The name of the [ERB] template to use for the generation of the `mcelog.conf` file.
# @param service_name
#   The name of the service.
# @param service_stdout
#   Only for EL7. The value of the StandardOutput parameter in the systemd script.
#
class mcelog (
  String $package_name,
  Stdlib::Absolutepath $config_file_path,
  String $config_file_template,
  String $service_name,
  String $service_stdout,
) {
  package { $package_name:
    ensure => present,
  }

  file { 'mcelog.conf':
    ensure  => 'file',
    path    => $config_file_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($config_file_template),
    require => Package[$package_name],
  }

  systemd::unit_file { 'mcelog.service':
    content => epp('mcelog/mcelog.service.epp', { standard_output => $service_stdout }),
    require => Package[$package_name],
  }
  ~> service { 'mcelog':
    ensure    => running,
    enable    => true,
    name      => $service_name,
    subscribe => File['mcelog.conf'],
  }
}
