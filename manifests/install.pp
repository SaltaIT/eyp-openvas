class openvas::install inherits openvas {

  if($openvas::manage_package)
  {
    package { $openvas::params::package_name:
      ensure => $openvas::package_ensure,
    }
  }

}
