class openvas::config inherits openvas {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  file { '/etc/sysconfig/gsad':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/openvassd.erb"),
  }

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
    timeout => 0,
    creates => "${openvas::plugins_folder}/md5sums",
  }

  # ERROR: No users found. You need to create at least one user to log in.
  # It is recommended to have at least one user with role Admin.
  # FIX: create a user by running 'openvasmd --create-user=<name> --role=Admin &&
  #                                openvasmd --user=<name> --new-password=<password>'
  exec { 'admin user openvas':
    command => "bash -c 'openvasmd --create-user=${openvas::admin_user} --role=Admin && openvasmd --user=${openvas::admin_user} --new-password=${openvas::admin_password}'",
    unless  => 'openvasmd --get-users | grep -E "\\b${openvas::admin_user}\\b"'
  }

  # ERROR: No OpenVAS SCAP database found. (Tried: /var/lib/openvas/scap-data/scap.db)
  # FIX: Run a SCAP synchronization script like greenbone-scapdata-sync.
  exec { 'greenbone-scapdata-sync initial update':
    command => 'greenbone-scapdata-sync',
    timeout => 0,
    creates => '/var/lib/openvas/scap-data/scap.db',
  }

  # ERROR: No OpenVAS CERT database found. (Tried: /var/lib/openvas/cert-data/cert.db)
  # FIX: Run a CERT synchronization script like greenbone-certdata-sync.
  exec { 'greenbone-certdata-sync initial update':
    command => 'greenbone-certdata-sync',
    timeout => 0,
    creates => '/var/lib/openvas/cert-data/cert.db',
  }

  # ERROR: Your OpenVAS certificate infrastructure did NOT pass validation.
  # FIX: Run 'openvas-manage-certs -a'.
  #
  # [root@centos7 logs]# openvas-manage-certs -V; echo $?
  # ERROR: certtool binary not found!
  # 1
  exec { 'OpenVAS certificate infrastructure':
    command => 'openvas-manage-certs -a',
    timeout => 0,
    unless  => 'openvas-manage-certs -V',
  }




}
