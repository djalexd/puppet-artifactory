
class artifactory::build::backups inherits artifactory::params {
  $prefix = "<backups>"
  $suffix = "</backups>"
  $artifactory_backups_file = "${artifactory_temp_dir}/backups.fragment"

  exec { 'build_backups':
    command => "/bin/echo '${prefix}' > ${artifactory_backups_file} && /bin/cat ${artifactory_temp_dir}/backup-*.xml.content >> ${artifactory_backups_file} && /bin/echo '${suffix}' >> ${artifactory_backups_file}",
    notify => Class["artifactory::service"]
  }

}