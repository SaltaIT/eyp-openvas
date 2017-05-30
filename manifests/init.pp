class openvas(
                            $manage_package        = true,
                            $package_ensure        = 'installed',
                            $manage_service        = true,
                            $manage_docker_service = true,
                            $service_ensure        = 'running',
                            $service_enable        = true,
                            $plugins_folder        = '/var/lib/openvas/plugins',
                            $admin_user            = 'root',
                            $admin_password        = 'dmlzY2EgY2F0YWx1bnlhCg',
                          ) inherits openvas::params{

  validate_re($package_ensure, [ '^present$', '^installed$', '^absent$', '^purged$', '^held$', '^latest$' ], 'Not a supported package_ensure: present/absent/purged/held/latest')

  class { '::openvas::install': }
  -> class { '::openvas::config': }
  ~> class { '::openvas::service': }
  -> Class['::openvas']

}
