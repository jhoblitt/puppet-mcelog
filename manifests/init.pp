#
# @summary Manage mcelog
#
# @param package_name
#   The name of the package.
# @param config_file_path
#   The path of mcelog configuration file.
# @param service_name
#   The name of the service.
# @param service_ensure
#   The expected state of the service
# @param service_enable
#   Should the service start on boot?
# @param config_file_content
#   Literal string to write to config_file_path.
#
class mcelog (
  String $package_name,
  Stdlib::Absolutepath $config_file_path,
  String $service_name,
  Stdlib::Ensure::Service $service_ensure,
  Boolean $service_enable,
  Optional[String] $config_file_content = undef,
) {
  ensure_packages($package_name)

  if $config_file_content {
    file { 'mcelog.conf':
      ensure  => 'file',
      path    => $config_file_path,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => $config_file_content,
      require => Package[$package_name],
      notify  => Service['mcelog'],
    }
  }

  service { 'mcelog':
    ensure  => $service_ensure,
    enable  => $service_enable,
    name    => $service_name,
    require => Package[$package_name],
  }
}
