class mcelog::params {
  $package_name = 'mcelog'
  $service_name = 'mcelogd'

  # MCE is only supported on x86_64
  case $::architecture {
    'x86_64': {}
    default: {
      fail("Module ${module_name} is not supported on architecture: ${::architecture}")
    }
  }
  case $::osfamily {
    'redhat': {
      case $::operatingsystemmajrelease {
        5: {
          $config_file_path = '/etc/mcelog.conf'
          $service_manage   = false
        }
        6: {
          $config_file_path = '/etc/mcelog/mcelog.conf'
          $service_manage   = true
        }
        default: {
          fail("Module ${module_name} is not supported on operatingsystemmajrelease: ${::operatingsystemmajrelease}")
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported on osfamily: ${::osfamily}")
    }
  }
}
