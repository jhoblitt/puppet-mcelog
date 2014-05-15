class mcelog::params {
  $package_name     = 'mcelog'
  $config_file_path = '/etc/mcelog/mcelog.conf'
  $service_name     = 'mcelogd'

  case $::architecture {
    'x86_64': {}
    default: {
      fail("Module ${module_name} is not supported on architecture: ${::architecture}")
    }
  }
  case $::osfamily {
    'redhat': {}
    default: {
      fail("Module ${module_name} is not supported on osfamily: ${::osfamily}")
    }
  }
}
