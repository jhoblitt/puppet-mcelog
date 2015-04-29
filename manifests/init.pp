# mcelog class
class mcelog (
  $package_name         = $::mcelog::params::package_name,
  $config_file_path     = $::mcelog::params::config_file_path,
  $config_file_template = $::mcelog::params::config_file_template,
  $service_name         = $::mcelog::params::service_name,
  $service_stdout       = 'null',
) inherits mcelog::params {

  validate_string($package_name)
  validate_string($config_file_path)
  validate_string($config_file_template)
  validate_string($service_name)

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
    require => Package[$package_name]
  }

  if $mcelog::params::service_manage {
    if $::operatingsystemmajrelease == '7' {
      file { 'mcelog.service':
        ensure  => 'file',
        path    => '/usr/lib/systemd/system/mcelog.service',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template('mcelog/mcelog.service.erb'),
        notify  => Exec['systemd_reload'],
        require => Package[$package_name]
      }
      exec { 'systemd_reload':
        command     => '/usr/bin/systemctl daemon-reload',
        notify      => Service['mcelog'],
        refreshonly => true
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
