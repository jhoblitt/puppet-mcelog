class mcelog {
  include mcelog::install, mcelog::config, mcelog::service
}

class mcelog::install {
  package { 'mcelog':
    ensure => present,
  }
}

class mcelog::config {

  file { '/etc/mcelog/mcelog.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => present,
    content => template('mcelog/mcelog.conf.erb'),
    require => Class['mcelog::install'],
    notify  => Class['mcelog::service'],
  }
}

class mcelog::service {
  service { 'mcelogd':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => Class['mcelog::config'],
  }
}
