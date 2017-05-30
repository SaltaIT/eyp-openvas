class openvas::config inherits openvas {

  file { '/etc/openvas/openvassd.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/openvassd.erb"),
  }

  # /var/lib/openvas/plugins/md5sums
  exec { 'greenbone-nvt-sync initial update':
    command => 'greenbone-nvt-sync',
    creates => "${openvas::plugins_folder}/md5sums",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

}
