
class artifactory::build::virtuals inherits artifactory::params {
  $prefix = "<virtualRepositories>"
  $suffix = "</virtualRepositories>"
  $artifactory_virtuals_file = "${artifactory_temp_dir}/virtuals.fragment"

  exec { 'build_virtual_repos':
    command => "/bin/echo '${prefix}' > ${artifactory_virtuals_file} && /bin/cat ${artifactory_temp_dir}/virtual-*.xml.content >> ${artifactory_virtuals_file} && /bin/echo '${suffix}' >> ${artifactory_virtuals_file}",
    notify => Class["artifactory::service"]
  }
}