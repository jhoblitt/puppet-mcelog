class mcelog {
  include mcelog::params

  package { $::mcelog::params::package_name:
    ensure => present,
  } ->
  file { $::mcelog::params::config_file_path:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('mcelog/mcelog.conf.erb'),
    notify  => Class['mcelog::service'],
  } ->
  service { 'mcelog':
    ensure     => running,
    name       => $::mcelog::params::service_name,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}
