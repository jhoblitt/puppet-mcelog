# mcelog class
class mcelog (
  $config_file_template = $::mcelog::params::config_file_template,
) inherits mcelog::params {
  validate_string($config_file_template)

  package { $::mcelog::params::package_name:
    ensure => present,
  } ->
  file { 'mcelog.conf':
    ensure  => 'file',
    path    => $::mcelog::params::config_file_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($config_file_template),
  }

  if $mcelog::params::service_manage {
    service { 'mcelog':
      ensure     => running,
      name       => $::mcelog::params::service_name,
      hasstatus  => true,
      hasrestart => true,
      enable     => true,
      subscribe  => File['mcelog.conf'],
    }
  }
}
