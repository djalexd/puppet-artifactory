#
# An advanced feature of Artifactory, the repository layout,
# a definition that can be used for local & virtual repository.
#
# It is harder to build layouts, so unless you know exactly
# what do to, better leave the default values, as described in
# artifactory::init.pp file.
#
# Usage:
#
#   artifactory::repo_layout { 'maven-1-default':
#     name                    => 'maven-1-default',
#     artifact_path_pattern   => '[org]/[type]s/[module]-[baseRev](-[fileItegRev])(-[classifier]).[ext]',
#     descriptor_path_pattern => '[org]/[type]s/[module]-[baseRev](-[fileItegRev]).pom',
#   }
#
define artifactory::repo_layout(
  $artifact_path_pattern,
  $descriptor_path_pattern,
  $distinctive_descriptor_path_pattern = 'true',
  $folder_integration_revision_reg_exp = '.+',
  $file_integration_revision_reg_exp   = '.+') {

  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { "${artifactory::params::artifactory_temp_dir}/repo_layout-${name}.xml.content":
    ensure  => present,
    content => template('artifactory/repo_layout.xml.erb'),
    notify  => Class['artifactory::build::layouts'],
  }

}