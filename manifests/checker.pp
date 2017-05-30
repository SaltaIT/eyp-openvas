class openvas::checker(
                        $basedir = '/opt/openvaschecker',
                      ) inherits openvas::params {
  Exec {
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
	}

  exec { "mkdir p openvaschecker ${basedir}":
    command => "mkdir -p  ${basedir}/bin",
    creates => "${basedir}/bin",
  }

  file { "${basedir}/bin/openvas-checker":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => "puppet:///modules/${module_name}/openvas-checker",
    require => Exec["mkdir p openvaschecker ${basedir}"],
}
