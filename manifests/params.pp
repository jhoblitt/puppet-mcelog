# mcelog::params
class mcelog::params {
  $package_name         = 'mcelog'
  $config_file_template = 'mcelog/mcelog.conf.erb'

  # MCE is only supported on x86_64
  if ($facts['os']['architecture'] != 'x86_64') and ($facts['os']['architecture'] != 'amd64') {
    fail("Module ${module_name} is not supported on architecture: ${facts['os']['architecture']}")
  }

  case $facts['os']['family'] {
    'RedHat': {
      case $facts['os']['name'] {
        'Fedora': {
          $config_file_path = '/etc/mcelog/mcelog.conf'
          $service_manage   = true
          $service_name     = 'mcelog'
        }
        default: {
          case $facts['os']['release']['major'] {
            '5': {
              $config_file_path = '/etc/mcelog.conf'
              $service_manage   = false
              $service_name     = 'mcelogd'
            }
            '6': {
              $config_file_path = '/etc/mcelog/mcelog.conf'
              $service_manage   = true
              $service_name     = 'mcelogd'
            }
            '7': {
              $config_file_path = '/etc/mcelog/mcelog.conf'
              $service_manage   = true
              $service_name     = 'mcelog'
            }
            default: {
              fail("Module ${module_name} is not supported on operatingsystemmajrelease: ${facts['os']['release']['major']}")
            }
          }
        }
      }
    }
    'Debian': {
      case $facts['os']['release']['major'] {
        '6', '7', '8', '12.04', '14.04': {
          $config_file_path = '/etc/mcelog/mcelog.conf'
          $service_manage   = true
          $service_name     = 'mcelog'
        }
        default: {
          fail("Module ${module_name} is not supported on operatingsystemmajrelease: ${facts['os']['release']['major']}")
        }
      }
    }
    default: {
      fail("Module ${module_name} is not supported on osfamily: ${facts['os']['family']}")
    }
  }
}
