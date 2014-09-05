# mcelog::params
class mcelog::params {

  # MCE is only supported on x86_64
  if $::architecture != 'x86_64' {
      fail("Module ${module_name} not supported on: ${::architecture}")
  }

  case $::osfamily {
    'redhat': {
      $package_name         = 'mcelog'
      $service_name         = 'mcelogd'
      $config_file_template = 'mcelog/mcelog.conf.erb'
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
          fail("Module ${module_name} is not supported on
               operatingsystemmajrelease: ${::operatingsystemmajrelease}")
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported on osfamily: ${::osfamily}")
    }
  }
}
