class openvas::service inherits openvas {

  #
  validate_bool($openvas::manage_docker_service)
  validate_bool($openvas::manage_service)
  validate_bool($openvas::service_enable)

  validate_re($openvas::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${openvas::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $openvas::manage_docker_service)
  {
    if($openvas::manage_service)
    {
      service { $openvas::params::service_name:
        ensure => $openvas::service_ensure,
        enable => $openvas::service_enable,
      }
    }
  }
}
