
class artifactory::build::locals inherits artifactory::params {
  $prefix = "<localRepositories>"
  $suffix = "</localRepositories>"
  $artifactory_locals_file = "${artifactory_temp_dir}/locals.fragment"

  exec { 'build_local_repos':
    command => "/bin/echo '${prefix}' > ${artifactory_locals_file} && /bin/cat ${artifactory_temp_dir}/local-*.xml.content >> ${artifactory_locals_file} && /bin/echo '${suffix}' >> ${artifactory_locals_file}",
    notify => Class["artifactory::service"]
  }
}