
# This class is not called directly
class artifactory::params {

  # The temporary directory where all templates are rendered
  # and built.
  $artifactory_temp_dir = '/tmp/artifactory_cfg'

  # The file where entire config will be saved.
  $artifactory_cfg_file = "${artifactory_temp_dir}/artifactory.config.latest.xml"
}