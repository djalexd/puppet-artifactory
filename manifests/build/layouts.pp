
class artifactory::build::layouts inherits artifactory::params {
  $prefix = "<repoLayouts>"
  $suffix = "</repoLayouts>"
  $artifactory_layouts_file = "${artifactory_temp_dir}/layouts.fragment"

  exec { 'build_layouts':
    command => "/bin/echo '${prefix}' > ${artifactory_layouts_file} && /bin/cat ${artifactory_temp_dir}/repo_layout-*.xml.content >> ${artifactory_layouts_file} && /bin/echo '${suffix}' >> ${artifactory_layouts_file}",
    notify => Class["artifactory::service"]
  }

}