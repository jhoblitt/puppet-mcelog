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
  String $package_name                   = $mcelog::params::package_name,
  Stdlib::Absolutepath $config_file_path = $mcelog::params::config_file_path,
  String $config_file_template           = $mcelog::params::config_file_template,
  String $service_name                   = $mcelog::params::service_name,
  String $service_stdout                 = 'null',
) inherits mcelog::params {
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

  if $mcelog::params::service_manage {
    if $facts['os']['family'] == 'Redhat' and $facts['os']['release']['major'] == '7' {
      file { 'mcelog.service':
        ensure  => 'file',
        path    => '/usr/lib/systemd/system/mcelog.service',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('mcelog/mcelog.service.erb'),
        notify  => Exec['systemd_reload'],
        require => Package[$package_name],
      }
      exec { 'systemd_reload':
        command     => '/usr/bin/systemctl daemon-reload',
        notify      => Service['mcelog'],
        refreshonly => true,
      }
    }
    service { 'mcelog':
      ensure     => running,
      enable     => true,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => File['mcelog.conf'],
    }
  }
}
