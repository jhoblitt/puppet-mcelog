class mcelog {
  include mcelog::params

  package { $::mcelog::params::package_name:
    ensure => present,
  } ->
  file { 'mcelog.conf':
    ensure  => 'file',
    path    => $::mcelog::params::config_file_path,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('mcelog/mcelog.conf.erb'),
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
