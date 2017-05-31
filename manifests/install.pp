class openvas::install inherits openvas {

  include ::art

  class { 'redis':
    require => Class['::art'],
  }

  ->

  redis::instance { 'openvas':
    unixsocket => '/tmp/redis.sock',
    listen_tcp => false,
  }

  if($openvas::manage_package)
  {
    package { $openvas::params::package_name:
      ensure => $openvas::package_ensure,
      require => [ Class['::art'], Redis::Instance['openvas'] ],
    }

    package { $openvas::params::latex_packages:
      ensure => $openvas::package_ensure,
      require => [ Class['::art'], Redis::Instance['openvas'] ],
    }
  }

}
