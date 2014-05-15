class mcelog {
  package { 'mcelog':
    ensure => present,
  } ->
  file { '/etc/mcelog/mcelog.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('mcelog/mcelog.conf.erb'),
    notify  => Class['mcelog::service'],
  } ->
  service { 'mcelogd':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
  }
}
