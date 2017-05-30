class openvas::config inherits openvas {

  file { '/etc/openvas/openvassd.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template("${module_name}/openvassd.erb"),
  }

}
