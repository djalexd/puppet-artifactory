
class artifactory::config(
  $add_default_repo_layouts = "true"
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { "${artifactory::params::artifactory_temp_dir}":
    ensure => directory
  }

  file { "${artifactory::params::artifactory_temp_dir}/prepend.xml.cfg":
    ensure   => file,
    content  => template('artifactory/prepend.xml.cfg'),
  }

  file { "${artifactory::params::artifactory_temp_dir}/append.xml.cfg":
    ensure   => file,
    content  => template('artifactory/append.xml.cfg'),
  }

  # Add some default repo layouts.
  if add_default_repo_layouts == 'true' {

    # As configured from Artifactory 2.6.7+
    artifactory::repo_layout { 'maven-2-default':
      artifact_path_pattern => '[orgPath]/[module]/[baseRev](-[folderItegRev])/[module]-[baseRev](-[fileItegRev])(-[classifier]).[ext]',
      distinctive_descriptor_path_pattern => 'true',
      descriptor_path_pattern => '[orgPath]/[module]/[baseRev](-[folderItegRev])/[module]-[baseRev](-[fileItegRev])(-[classifier]).pom',
      folder_integration_revision_reg_exp => 'SNAPSHOT',
      file_integration_revision_reg_exp => 'SNAPSHOT|(?:(?:[0-9]{8}.[0-9]{6})-(?:[0-9]+))',
    }

    artifactory::repo_layout { 'ivy-default':
      artifact_path_pattern => '[org]/[module]/[baseRev](-[folderItegRev])/[type]s/[module](-[classifier])-[baseRev](-[fileItegRev]).[ext]',
      distinctive_descriptor_path_pattern => 'true',
      descriptor_path_pattern => '[org]/[module]/[baseRev](-[folderItegRev])/[type]s/ivy-[baseRev](-[fileItegRev]).xml',
      folder_integration_revision_reg_exp => '\d{14}',
      file_integration_revision_reg_exp => '\d{14}',
    }

    artifactory::repo_layout { 'gradle-default':
      artifact_path_pattern => '[org]/[module]/[baseRev](-[folderItegRev])/[module]-[baseRev](-[fileItegRev])(-[classifier]).[ext]',
      distinctive_descriptor_path_pattern => 'true',
      descriptor_path_pattern => '[org]/[module]/ivy-[baseRev](-[fileItegRev]).xml',
      folder_integration_revision_reg_exp => '\d{14}',
      file_integration_revision_reg_exp => '\d{14}',
    }

    artifactory::repo_layout { 'maven-1-default':
      artifact_path_pattern => '[org]/[type]s/[module]-[baseRev](-[fileItegRev])(-[classifier]).[ext]',
      distinctive_descriptor_path_pattern => 'true',
      descriptor_path_pattern => '[org]/[type]s/[module]-[baseRev](-[fileItegRev]).pom',
      folder_integration_revision_reg_exp => '.+',
      file_integration_revision_reg_exp => '.+',
    }
  }
}