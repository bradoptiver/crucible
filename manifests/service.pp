class crucible::service inherits crucible {

  if $crucible::service_manage == true {

    if $facts['service_provider'] == 'systemd' {
      $init_file='/etc/systemd/crucible.service'
      $init_template='crucible.service.erb'
      $init_perms='0664'
    } else {
      $init_file='/etc/init.d/crucible'
      $init_file_template='crucible-init.sh.erb'
      $init_perms='0755'
    }

    file { $init_file:
      ensure  => file,
      content => template("crucible/${init_template}"),
      mode    => $init_perms,
    }

    service { 'crucible':
      ensure     => $crucible::service_ensure,
      enable     => $crucible::service_enable,
      name       => $crucible::service_name,
      hasstatus  => true,
      hasrestart => true,
      require    => File[$init_file],
    }
  }
}
