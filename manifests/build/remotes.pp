
class artifactory::build::remotes inherits artifactory::params {
  $prefix = "<remoteRepositories>"
  $suffix = "</remoteRepositories>"
  $artifactory_remotes_file = "${artifactory_temp_dir}/remotes.fragment"

  exec { 'build_remote_repos':
    command => "/bin/echo '${prefix}' > ${artifactory_remotes_file} && /bin/cat ${artifactory_temp_dir}/remote-*.xml.content >> ${artifactory_remotes_file} && /bin/echo '${suffix}' >> ${artifactory_remotes_file}",
    notify => Class["artifactory::service"]
  }
}