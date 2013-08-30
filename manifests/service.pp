
# This class file should not be called directly.
class artifactory::service inherits artifactory::params {

  $prefix = "${artifactory_temp_dir}/prepend.xml.cfg"
  $suffix = "${artifactory_temp_dir}/append.xml.cfg"

  # Compiles all segments, composed of local, remote and
  # virtual repositories, along with security, backups,
  # indexers and some default values (that are not handled
  # yet, like repo layouts, security).
  exec { 'build_config':
      command => "/bin/cat ${prefix} > ${artifactory_cfg_file} && /bin/cat ${artifactory_temp_dir}/*.fragment >> ${artifactory_cfg_file} && /bin/cat ${suffix} >> ${artifactory_cfg_file}"
  }
}