class crucible (
  $version = '4.0.3',
  $service_manage = true,
  $service_ensure = 'running',
  $service_enable = true,
  $service_name = 'crucible',
  $service_user = 'crucible',
  $install_java = true,
  $install_dir = '/opt/crucible',
  $fisheye_inst = '/opt/crucible-data',
  $fisheye_opts = '',
  $install_unzip = true,
  $install_wget = true,
  $download_url = 'https://www.atlassian.com/software/crucible/downloads/binary',
) {

  validate_re($version, '^.*\.*\.*$')
  validate_bool($service_manage)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_string($service_name)
  validate_string($service_user)
  validate_bool($install_java)
  validate_absolute_path($install_dir)
  validate_absolute_path($fisheye_inst)

  class { '::crucible::install': } ->
  class { '::crucible::config': } ~>
  class { '::crucible::service': }

}
